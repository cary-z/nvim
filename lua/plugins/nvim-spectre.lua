return {
  "windwp/nvim-spectre",
  lazy = true,
  cmd = { "Spectre" },
  keys = {
    {
      "<leader>r",
      function()
        require("spectre").open()
      end,
      desc = "Open Spectre",
    },
  },
  config = function()
    require("spectre").setup({
      replace_vim_cmd = 'sed -i ""',
    })
  end,
}
