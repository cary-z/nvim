-- ~/.config/nvim/lua/plugins/comment.lua
return {
  "numToStr/Comment.nvim",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  opts = {
    -- 启用上下文感知注释，尤其是 TSX / JSX 中用 {/* */} 注释元素
    pre_hook = function(ctx)
      local U = require("Comment.utils")

      -- 只在 ts/tsx 文件中启用 context_commentstring
      if vim.bo.filetype == "typescriptreact" or vim.bo.filetype == "javascriptreact" then
        local location = nil
        if ctx.ctype == U.ctype.block then
          location = require("ts_context_commentstring.utils").get_cursor_location()
        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
          location = require("ts_context_commentstring.utils").get_visual_start_location()
        end

        return require("ts_context_commentstring.internal").calculate_commentstring({
          key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
          location = location,
        })
      end
    end,
  },
  lazy = false, -- 立即加载，避免注释按键失效
}
