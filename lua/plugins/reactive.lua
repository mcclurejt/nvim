return {
  "rasulomaroff/reactive.nvim",
  enabled = true,
  config = function()
    local colors = require("catppuccin.palettes").get_palette("mocha")
    local blend = require("catppuccin.utils.colors").blend
    require("reactive").load_preset("catppuccin-mocha-cursorline")
    require("reactive").load_preset("catppuccin-mocha-cursor")
    require("reactive").setup({
      configs = {
        ["catppuccin-mocha-cursorline"] = {
          modes = {
            i = {
              winhl = {
                CursorLine = { bg = blend(colors.green, colors.base, 0.15) },
                CursorLineNr = { bg = blend(colors.green, colors.base, 0.15) },
              },
            },
          },
        },
      },
    })
  end,
}
