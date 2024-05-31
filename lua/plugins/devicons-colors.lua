return {
  "rachartier/tiny-devicons-auto-colors.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  config = function()
    local mocha = require("catppuccin.palettes").get_palette("mocha")
    local brighten = require("catppuccin.utils.colors").brighten
    -- local macchiato = require("catppuccin.palettes").get_palette("macchiato")
    -- local latte = require("catppuccin.palettes").get_palette("latte")
    local colors = {}
    for k, v in pairs(mocha) do
      colors[k] = brighten(v, 0.1)
    end
    -- for _, v in pairs(macchiato) do
    --   colors.insert(v)
    -- end
    -- for _, v in pairs(latte) do
    --   colors.insert(v)
    -- end
    require("tiny-devicons-auto-colors").setup({
      colors = mocha,
      precise_search = {
        threshold = 50,
      },
    })
  end,
}
