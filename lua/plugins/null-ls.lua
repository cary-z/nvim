return {}
-- return {
--   "jose-elias-alvarez/null-ls.nvim",
--   config = function()
--     local null_ls = require("null-ls")
--     -- 配置 null-ls
--     null_ls.setup({
--       sources = {
--         null_ls.builtins.diagnostics.eslint_d.with({
--           command = "eslint_d",
--           diagnostics_format = "[eslint] #{m}\n(#{c})",
--         }),
--         null_ls.builtins.formatting.prettier.with({
--           command = "prettier",
--         }),
--       },
--       on_attach = function(client, bufnr)
--         if client.server_capabilities.documentFormattingProvider then
--           vim.api.nvim_create_autocmd("BufWritePre", {
--             group = vim.api.nvim_create_augroup("Format", { clear = true }),
--             buffer = bufnr,
--             callback = function()
--               vim.lsp.buf.formatting_sync()
--             end,
--           })
--         end
--       end,
--     })
--   end,
-- }
