return {
  "rlychrisg/keepcursor.nvim",
  opts = {
    enabled_on_start_v = "middle",
    enabled_on_start_h = "left",
  },
  keys = {
    {
      "<leader>zt",
      ":ToggleCursorTop<CR>",
      { noremap = true, silent = true, desc = "KeepCursor: keep cursor positioned at top on cursor move" },
    },
    {
      "<leader>zb",
      ":ToggleCursorBot 2<CR>",
      { noremap = true, silent = true, desc = "KeepCursor: keep cursor positioned at bottom on cursor move" },
    },
    {
      "<leader>zz",
      ":ToggleCursorMid<CR>",
      { noremap = true, silent = true, desc = "KeepCursor: keep cursor positioned at middle on cursor move" },
    },
    {
      "<leader>zs",
      ":ToggleCursorLeft<CR>",
      { noremap = true, silent = true, desc = "KeepCursor: keep cursor positioned at left on cursor move" },
    },
  },
}
