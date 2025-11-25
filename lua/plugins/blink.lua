return {
  {
    "saghen/blink.cmp",
    ---@param opts blink.cmp.Config
    opts = function(_, opts)
      opts.keymap = opts.keymap or {}
      opts.keymap["<Tab>"] = {
        LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
        "select_and_accept",
        "fallback",
      }
    end,
  },
}

