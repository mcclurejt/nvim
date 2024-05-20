return {
  "akinsho/bufferline.nvim",
  opts = {
    highlights = require("catppuccin.groups.integrations.bufferline").get(),
    options = {
      themable = true,
      buffer_close_icon = nil,
    },
  },
}
