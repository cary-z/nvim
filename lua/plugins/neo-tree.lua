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
          -- 复制文件名
          ["y"] = function(state)
            local node = state.tree:get_node()
            local filepath = node:get_id()
            local filename = vim.fn.fnamemodify(filepath, ":t") -- 提取文件名
            vim.fn.setreg("+", filename) -- 将文件名复制到系统剪贴板
            print("Copied to clipboard: " .. filename)
          end,
          -- 复制相对路径
          ["<C-y>"] = function(state)
            local node = state.tree:get_node()
            local filepath = node:get_id()
            local project_root = vim.fn.getcwd() -- 获取当前项目的根目录
            local relative_path = vim.fn.fnamemodify(filepath, ":." .. project_root)
            vim.fn.setreg("+", relative_path) -- 将相对路径复制到系统剪贴板
            print("Copied to clipboard: " .. relative_path)
          end,
          -- 复制绝对路径
          ["Y"] = function(state)
            local node = state.tree:get_node()
            local filepath = node:get_id()
            vim.fn.setreg("+", filepath) -- 将文件路径复制到系统剪贴板
            print("Copied to clipboard: " .. filepath)
          end,
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
