return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsserver = false,
        ts_ls = false,
        volar = false,
        vtsls = false,
      },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")
      local mason_registry_ok, mason_registry = pcall(require, "mason-registry")

      local function with_buffer_keymaps(_, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end
        map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
        -- map("n", "K", vim.lsp.buf.hover, "Hover")
      end

      local function get_tsdk(root_dir)
        if root_dir then
          local project_ts = util.path.join(root_dir, "node_modules", "typescript", "lib")
          if vim.loop.fs_stat(project_ts) then
            return project_ts
          end
        end
        if mason_registry_ok then
          local ok, tsserver_pkg = pcall(mason_registry.get_package, "typescript-language-server")
          if ok then
            local ts_path = util.path.join(tsserver_pkg:get_install_path(), "node_modules", "typescript", "lib")
            if vim.loop.fs_stat(ts_path) then
              return ts_path
            end
          end
        end
        local global_ts = vim.fn.expand("~/.npm/lib/node_modules/typescript/lib")
        if vim.loop.fs_stat(global_ts) then
          return global_ts
        end
        return nil
      end

      local function get_vue_typescript_plugin()
        if not mason_registry_ok then
          return nil
        end
        local ok, vue_pkg = pcall(mason_registry.get_package, "vue-language-server")
        if not ok or not vue_pkg then
          return nil
        end
        if type(vue_pkg.get_install_path) ~= "function" then
          return nil
        end
        local install_path = vue_pkg:get_install_path()
        if not install_path then
          return nil
        end
        local language_server_path = util.path.join(
          install_path,
          "node_modules",
          "@vue",
          "language-server"
        )
        if vim.loop.fs_stat(language_server_path) then
          return {
            name = "@vue/typescript-plugin",
            location = language_server_path,
            languages = { "vue" },
            configNamespace = "typescript",
            enableForWorkspaceTypeScriptVersions = true,
          }
        end
        return nil
      end

      local vue_ts_plugin = get_vue_typescript_plugin()

      -- 配置 ESLint LSP
      lspconfig.eslint.setup({
        settings = {
          eslint = {
            enable = true,
            packageManager = "npm", -- 这里可以是 npm 或其他包管理器
            autoFixOnSave = false,
            options = {
              cache = true,
              cacheLocation = ".eslintcache",
            },
          },
        },
        on_attach = with_buffer_keymaps,
      })

      -- 配置 Volar LSP（仅处理 Vue）
      lspconfig.volar.setup({
        on_init = function(client)
          client.handlers["tsserver/request"] = function(_, result, ctx)
            local ts_clients = vim.lsp.get_clients({ bufnr = ctx.bufnr, name = "vtsls" })
            local ts_ls_clients = vim.lsp.get_clients({ bufnr = ctx.bufnr, name = "ts_ls" })
            local candidates = {}

            vim.list_extend(candidates, ts_clients)
            vim.list_extend(candidates, ts_ls_clients)

            if #candidates == 0 then
              -- vim.notify(
              --   "[volar] could not find vtsls/ts_ls client for TypeScript features",
              --   vim.log.levels.ERROR
              -- )
              return
            end

            local ts_client = candidates[1]
            local payload = result[1]
            local request_id, command, data = unpack(payload)

            ts_client:exec_cmd({
              title = "vue_ts_bridge",
              command = "typescript.tsserverRequest",
              arguments = { command, data },
            }, { bufnr = ctx.bufnr }, function(_, response)
              local body = response and response.body
              client:notify("tsserver/response", { { request_id, body } })
            end)
          end
        end,
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
          with_buffer_keymaps(client, bufnr)
        end,
        init_options = {
          typescript = {
            tsdk = "",
          },
        },
        filetypes = { "vue" },
        on_new_config = function(new_config, new_root_dir)
          local tsdk = get_tsdk(new_root_dir)
          if tsdk then
            new_config.init_options = new_config.init_options or {}
            new_config.init_options.typescript = new_config.init_options.typescript or {}
            new_config.init_options.typescript.tsdk = tsdk
          end
        end,
        root_dir = function(fname)
          return util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git")(fname)
            or util.path.dirname(fname)
        end,
      })

      -- 配置 vtsls，与 Volar 协同工作
      local vtsls_settings = {
        vtsls = {
          tsserver = {
            globalPlugins = {},
          },
        },
        typescript = {},
      }
      if vue_ts_plugin then
        table.insert(vtsls_settings.vtsls.tsserver.globalPlugins, vue_ts_plugin)
      end

      lspconfig.vtsls.setup({
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
          with_buffer_keymaps(client, bufnr)
        end,
        settings = vtsls_settings,
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
          "vue",
        },
        root_dir = function(fname)
          return util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git")(fname)
            or util.path.dirname(fname)
        end,
        on_new_config = function(new_config, new_root_dir)
          local tsdk = get_tsdk(new_root_dir)
          if tsdk then
            new_config.settings = new_config.settings or {}
            new_config.settings.typescript = new_config.settings.typescript or {}
            new_config.settings.typescript.tsdk = tsdk
          end
        end,
      })

      -- Tailwind CSS LSP
      lspconfig.tailwindcss.setup({
        on_attach = with_buffer_keymaps,
      })
    end,
  },
}
