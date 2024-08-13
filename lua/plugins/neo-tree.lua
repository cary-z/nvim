return {
  "nvim-neo-tree/neo-tree.nvim",
  config = function()
    require("neo-tree").setup({
      -- 其他配置选项
      window = {
        mappings = {
          ["<CR>"] = "open",    -- 默认是 Enter 键
          ["o"] = "open",       -- 你可以添加新的键映射，比如将 'o' 键映射为 'open'
          ["O"] = "open_split", -- 示例：将 'O' 键映射为在分割窗口中打开
          -- 你可以添加更多的自定义键映射
        },
      },
      filesystem = {
        filtered_items = {
          visible = true,      -- 显示隐藏文件
          hide_dotfiles = false, -- 不隐藏以 `.` 开头的文件
          hide_gitignored = false, -- 不隐藏在 .gitignore 中列出的文件
        },
      },
    })
  end,
}
