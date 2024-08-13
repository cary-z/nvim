local config = require "lazyvim.config"
return {
  {
    -- add tsserver and setup with typescript.nvim instead of lspconfig
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set("n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
    config = function()
      -- 配置 tsserver
      require('lspconfig').tsserver.setup {
        cmd = { "/Users/admin/Library/Caches/fnm_multishells/6048_1723170588197/bin/typescript-language-server", "--stdio" },
        on_attach = function(client, bufnr)
          local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
          local opts = { noremap = true, silent = true }

          -- 设置按键绑定，例如：
          buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
          buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
        end,
        flags = {
          debounce_text_changes = 150,
        },
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        root_dir = function() return vim.loop.cwd() end,
      }
    end,
    config = function()
      -- 配置 Volar LSP
      require('lspconfig').volar.setup {
        cmd = { "/Users/admin/Library/Caches/fnm_multishells/6048_1723170588197/bin/vue-language-server", "--stdio" },
        on_attach = function(client, bufnr)
          local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
          local opts = { noremap = true, silent = true }

          -- 设置按键绑定，例如：
          buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
          buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
        end,
        flags = {
          debounce_text_changes = 150,
        },
        filetypes = { 'vue' },
        root_dir = function() return vim.loop.cwd() end,
      }
    end
  },

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  { import = "lazyvim.plugins.extras.lang.typescript" },
}

