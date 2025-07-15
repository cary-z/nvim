return {
  "nvim-telescope/telescope.nvim",
  keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "ff",
        function() require("telescope.builtin").find_files({ cwd = vim.fn.getcwd() }) end,
        desc = "Find Plugin File",
      },
      {
        "fw",
        function() require("telescope.builtin").grep_string({ cwd = vim.fn.getcwd() }) end,
        desc = "Find Grep String",
      },
      {
        "fg",
        function() require("telescope.builtin").live_grep({ cwd = vim.fn.getcwd() }) end,
        desc = "Find Live Grep",
      },
  },
  -- change some options
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      layout_config = { prompt_position = "top" },
      sorting_strategy = "ascending",
      winblend = 0,
    },
  },
}
