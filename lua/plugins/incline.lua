return {
  "b0o/incline.nvim",
  enabled = true,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  config = function()
    local helpers = require("incline.helpers")
    local devicons = require("nvim-web-devicons")
    local clrs = require("catppuccin.palettes").get_palette("mocha")
    require("incline").setup({
      window = {
        padding = 0,
        margin = { horizontal = 2, vertical = 0 },
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
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if filename == "" then
          filename = "[No Name]"
        end
        local ft_icon, ft_color = devicons.get_icon_color(filename)
        local modified = vim.bo[props.buf].modified
        return {
          "\n",
          ft_icon and { "", guibg = clrs.base, guifg = ft_color } or "",
          ft_icon and { "" .. ft_icon .. "", guibg = ft_color, guifg = clrs.base } or "",
          guibg = ft_color,
          guifg = clrs.base,
          gui = "bold",
          {
            " " .. filename .. "",
            guibg = ft_color,
          },
          { "", guibg = clrs.base, guifg = ft_color },
        }
      end,
    })
  end,
}
