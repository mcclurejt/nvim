return {
  "b0o/incline.nvim",
  dependencies = {
    "kyazdani42/nvim-web-devicons",
    "catppuccin/nvim",
  },
  event = "VeryLazy",
  config = function()
    local helpers = require("incline.helpers")
    local devicons = require("nvim-web-devicons")
    local clrs = require("catppuccin.palettes").get_palette("mocha")
    require("incline").setup({
      window = {
        padding = 0,
        margin = { horizontal = 2, vertical = 2 },
        placement = {
          horizontal = "right",
          vertical = "top",
        },
      },
      hide = {
        cursorline = true,
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if filename == "" then
          filename = "[No Name]"
        end
        local ft_icon, ft_color = devicons.get_icon_color(filename)
        local modified = vim.bo[props.buf].modified
        return {
          -- { "", guifg = clrs.surface0, guibg = clrs.base } or "",
          ft_icon and { " " .. ft_icon .. " ", guibg = ft_color, guifg = clrs.surface0 } or "",
          guibg = clrs.surface0,
          {
            " " .. filename .. " ",
            gui = modified and "bold" or "regular",
            guibg = clrs.surface0,
            guifg = modified and clrs.flamingo or "#cdd6f4",
          },
          -- { "", guibg = clrs.base, guifg = clrs.surface0 },
        }
      end,
    })
  end,
}
