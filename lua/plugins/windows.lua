return {
  "anuvyklack/windows.nvim",
  dependencies = {
    "anuvyklack/middleclass",
    "anuvyklack/animation.nvim",
  },
  config = function()
    vim.o.winwidth = 10 -- 最小宽度为3列，避免完全消失
    vim.o.winminwidth = 3
    vim.o.equalalways = false

    require("windows").setup({
      animation = {
        enable = false,
        -- duration = 100,
      },
      ignore = { buftype = { "quickfix" } },
    })
  end,
}
