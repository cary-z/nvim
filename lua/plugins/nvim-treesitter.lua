-- return {}
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "bash",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "tsx",
      "typescript",
      "vim",
      "yaml",
    },
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false, -- 让 Comment.nvim 自己控制，不依赖 autocmd
  },
}
