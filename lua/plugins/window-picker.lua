return {
  "s1n7ax/nvim-window-picker",
  name = "window-picker",
  event = "VeryLazy",
  opts = {
    show_prompt = true,
    hint = "statusline-winbar",
    selection_chars = "ASDFGHJKL;",
    filter_rules = {
      bo = {
        filetype = { "NvimTree", "neo-tree", "notify", "incline" },
        buftype = { "terminal" },
      },
      include_current_win = true,
    },
  },
}
