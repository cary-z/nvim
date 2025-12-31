-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "gomod", "gowork", "gotmpl" },
  callback = function()
    -- 避免重复启动
    if #vim.lsp.get_clients({ bufnr = 0 }) == 0 then
      vim.cmd("LspStart gopls")
    end
  end,
})
