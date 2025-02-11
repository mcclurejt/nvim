return {
  "s1n7ax/nvim-window-picker",
  name = "window-picker",
  event = "VeryLazy",
  opts = {},
  config = function()
    local colors = require("catppuccin.palettes").get_palette("mocha")
    require("window-picker").setup({
      show_prompt = true,
      hint = "statusline-winbar",
      selection_chars = "ASDFGHJKL;",
      filter_rules = {
        bo = {
          filetype = { "NvimTree", "neo-tree", "notify", "incline" },
          buftype = { "terminal" },
        },
        include_current_win = true,
        autoselect_one = true,
      },
      highlights = {
        statusline = {
          focused = {
            fg = colors.base,
            bg = colors.red,
            bold = true,
          },
          unfocused = {
            fg = colors.base,
            bg = colors.red,
            bold = true,
          },
        },
        winbar = {
          focused = {
            fg = "#ededed",
            bg = "#e35e4f",
            bold = true,
          },
          unfocused = {
            fg = "#ededed",
            bg = "#44cc41",
            bold = true,
          },
        },
      },
    })
  end,
}
