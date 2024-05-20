return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.options.theme = "catppuccin"
    opts.options.section_separators = ""
    opts.options.component_separators = ""
    return opts
  end,
}
