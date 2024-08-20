return {
  "nvim-neo-tree/neo-tree.nvim",
  config = function()
    require("neo-tree").setup({
      -- 其他配置选项
      window = {
        mappings = {
          ["<CR>"] = "open", -- 默认是 Enter 键
          ["o"] = "open", -- 你可以添加新的键映射，比如将 'o' 键映射为 'open'
          ["O"] = "open_split", -- 示例：将 'O' 键映射为在分割窗口中打开
          -- 你可以添加更多的自定义键映射
        },
      },
      filesystem = {
        follow_current_file = true, -- 打开时自动选中当前文件
        hijack_netrw_behavior = "open_current", -- 替代 netrw 打开文件
        use_libuv_file_watcher = true, -- 使用 libuv 文件监视器
        filtered_items = {
          visible = true, -- 显示隐藏文件
          hide_dotfiles = false, -- 不隐藏以 `.` 开头的文件
          hide_gitignored = false, -- 不隐藏在 .gitignore 中列出的文件
        },
        bind_to_cwd = false, -- 不绑定到当前工作目录
        cwd_target = {
          type = "global", -- 设置根目录为全局项目根目录
        },
      },
      default_component_configs = {
        indent = {
          padding = 0, -- 缩进级别前的空白数
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
        },
      },
    })
  end,
}
