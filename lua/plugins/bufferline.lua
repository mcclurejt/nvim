return {
  "akinsho/bufferline.nvim",
  after = "catppuccin",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  enabled = true,
  keys = {
    { "gbp", "<cmd>BufferLineTogglePin<cr>", desc = "Pick Buffer", silent = true },
    { "gbh", "<cmd>BufferLineMovePrev<cr>", desc = "Move Buffer Left", silent = true },
    { "gbl", "<cmd>BufferLineMoveNext<cr>", desc = "Move Buffer Right", silent = true },
    { "<tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Cycle Next Buffer", silent = true },
    { "<s-tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Cycle Prev Buffer", silent = true },
  },
  opts = function(_, opts)
    local devicons = require("nvim-web-devicons")
    local ctp = require("catppuccin")
    local O = ctp.options
    local transparent_background = O.transparent_background
    local C = require("catppuccin.palettes").get_palette("mocha")
    local active_bg = transparent_background and "NONE" or C.surface0
    local inactive_bg = transparent_background and "NONE" or C.mantle
    local styles = { "bold", "italic" }
    local visible_fg = C.lavender
    local selected_fg = C.pink
    local inactive_fg = C.surface1
    -- opts.options.mode = "tabs"
    opts.highlights = require("catppuccin.groups.integrations.bufferline").get({
      styles = styles,
      custom = {
        all = {
          -- buffer_visible = {
          --   fg = mocha.lavender,
          --   bg = mocha.base,
          --   bold = true,
          --   styles = { "italic", "bold" },
          -- },
          -- buffer_selected = {
          --   fg = mocha.pink,
          --   bg = mocha.base,
          --   bold = true,
          -- },
          tab_selected = { fg = active_bg, bg = C.blue, bold = true },
          indicator_visible = { fg = C.pink, bg = active_bg, style = styles },
          indicator_selected = { fg = C.pink, bg = active_bg, style = styles },
          background = { fg = C.surface2, bg = inactive_bg },
          buffer_visible = { fg = visible_fg, bold = true, bg = active_bg },
          buffer_selected = { fg = selected_fg, bg = active_bg },
          hint = { fg = inactive_fg, bg = inactive_bg },
          hint_visible = { fg = visible_fg, bg = active_bg },
          hint_selected = { fg = selected_fg, bg = active_bg, style = styles },
          info = { fg = inactive_fg, bg = inactive_bg },
          info_visible = { fg = visible_fg, bg = active_bg },
          info_selected = { fg = selected_fg, bg = active_bg, style = styles },
          warning = { fg = inactive_fg, bg = inactive_bg },
          warning_visible = { fg = visible_fg, bg = active_bg },
          warning_selected = { fg = selected_fg, bg = active_bg, style = styles },
          error = { fg = inactive_fg, bg = inactive_bg },
          error_visible = { fg = visible_fg, bg = active_bg },
          error_selected = { fg = selected_fg, bg = active_bg, style = styles },
          hint_diagnostic = { highlight = "DiagnosticSignHint", bg = inactive_bg },
          hint_diagnostic_visible = { highlight = "DiagnosticSignHint", bg = active_bg },
          hint_diagnostic_selected = { highlight = "DiagnosticSignHint", bg = active_bg },
          info_diagnostic = { highlight = "DiagnosticSignInfo", bg = inactive_bg },
          info_diagnostic_visible = { highlight = "DiagnosticSignInfo", bg = active_bg },
          info_diagnostic_selected = { highlight = "DiagnosticSignInfo", bg = active_bg },
          warning_diagnostic = { highlight = "DiagnosticSignWarn", bg = inactive_bg },
          warning_diagnostic_visible = { highlight = "DiagnosticSignWarn", bg = active_bg },
          warning_diagnostic_selected = { highlight = "DiagnosticSignWarn", bg = active_bg },
          error_diagnostic = { highlight = "DiagnosticSignError", bg = inactive_bg },
          error_diagnostic_visible = { highlight = "DiagnosticSignError", bg = active_bg },
          error_diagnostic_selected = { highlight = "DiagnosticSignError", bg = active_bg },
          -- separator_selected = { fg = mocha.lavender, bg = mocha.base },
          -- separator_visible = { fg = mocha.lavender, bg = mocha.base },
          -- hint = { fg = mocha.surface1, bg = mocha.base },
          -- hint_diagnostic = { fg = mocha.surface1, bg = mocha.base },
          -- indicator_selected = {
          --   fg = mocha.red,
          -- },
        },
      },
    })
    opts.options.get_element_icon = function(element)
      -- element consists of {filetype: string, path: string, extension: string, directory: string}
      -- This can be used to change how bufferline fetches the icon
      -- for an element e.g. a buffer or a tab.
      -- e.g.
      local filename = vim.fn.fnamemodify(element.path, ":t")
      local icon, color = devicons.get_icon_color(filename)
      -- if vim.api.nvim_buf_get_name(0) == filename then
      --   return icon, "@diff.delta"
      -- end
      return icon
    end
    opts.options.always_show_bufferline = true
    opts.options.show_buffer_close_icons = false
    opts.options.show_close_icon = false
    opts.options.truncate_names = false
    opts.options.indicator = {
      -- icon = "", -- this should be omitted if indicator style is not 'icon'
      style = "none",
    }
    opts.options.groups = {
      items = {
        require("bufferline.groups").builtin.pinned:with({ icon = "  " }),
      },
    }
    return opts
  end,
}
