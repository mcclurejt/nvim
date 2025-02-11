return {
  "b0o/incline.nvim",
  dependencies = {
    "rachartier/tiny-devicons-auto-colors.nvim",
  },
  enabled = false,
  event = "VeryLazy",
  config = function()
    local helpers = require("incline.helpers")
    local devicons = require("nvim-web-devicons")
    local clrs = require("catppuccin.palettes").get_palette()
    require("incline").setup({
      window = {
        padding = 0,
        margin = { horizontal = 0, vertical = 2 },
        placement = {
          horizontal = "right",
          vertical = "top",
        },
      },
      hide = {
        focused_win = true,
        cursorline = true,
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":.")
        if filename == "" then
          filename = "[No Name]"
        end
        local ft_icon, ft_color = devicons.get_icon_color(filename)
        local modified = vim.bo[props.buf].modified
        return {
          -- { "", guibg = clrs.base, guifg = modified and clrs.peach or clrs.pink },
          guibg = modified and clrs.peach or clrs.pink,
          guifg = clrs.surface0,
          ft_icon and " " .. ft_icon .. "" or "   ",
          {
            " " .. filename .. " ",
            guifg = clrs.surface0,
            guibg = modified and clrs.peach or clrs.pink,
            gui = "bold",
          },
          -- { "", guibg = clrs.base, guifg = modified and clrs.peach or clrs.pink },
        }
      end,
    })
  end,
  opts = {},
}
