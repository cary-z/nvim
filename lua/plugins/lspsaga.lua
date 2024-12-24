return {
  "nvimdev/lspsaga.nvim",
  event = "BufRead",
  dependencies = { { "nvim-lspconfig" } },
  config = function()
    require("lspsaga").setup({
      ui = {
        code_action = "",
        devicon = true,
      },
      -- 在这里添加你的 lspsaga 配置选项
      lightbulb = {
        enable = true,
        sign = true,
        virtual_text = true,
      },
    })
  end,
}
