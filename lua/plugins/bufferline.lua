return {
  "akinsho/bufferline.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  enabled = false,
  keys = {
    { "gb", "<cmd>BufferLinePick<cr>", desc = "Pick Buffer", silent = true },
  },
  opts = function(_, opts)
    local devicons = require("nvim-web-devicons")
    local highlights = require("catppuccin.groups.integrations.bufferline").get({
      styles = { "bold" },
      custom = {},
    })()
    -- opts.options.mode = "tabs"
    opts.highlights = highlights
    -- opts.options.get_element_icon = function(element)
    --   -- element consists of {filetype: string, path: string, extension: string, directory: string}
    --   -- This can be used to change how bufferline fetches the icon
    --   -- for an element e.g. a buffer or a tab.
    --   -- e.g.
    --   local filename = vim.fn.fnamemodify(element.path, ":t")
    --   local icon, color = devicons.get_icon_color(filename)
    --   return icon
    -- end
    opts.options.always_show_bufferline = true
    opts.options.show_buffer_close_icons = false
    opts.options.show_close_icon = false
    opts.options.truncate_names = false
    return opts
  end,
}
