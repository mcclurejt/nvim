return {
  {
    "freddiehaddad/feline.nvim",
    opts = {},
    config = function(_, opts)
      vim.opt.laststatus = 3
      local clrs = require("catppuccin.palettes").get_palette()
      local ctp_feline = require("catppuccin.groups.integrations.feline")
      ctp_feline.setup({
        assets = {
          left_separator = "",
          right_separator = "",
          mode_icon = "",
          lsp = {
            server = "󰅡",
            error = "",
            warning = "",
            info = "",
            hint = "",
          },
          git = {
            branch = "",
            added = "",
            changed = "",
            removed = "",
          },
        },
        sett = {
          bkg = clrs.base,
        },
      })
      require("feline").setup({
        components = ctp_feline.get(),
      })
      -- require("feline").winbar.setup() -- to use winbar
      -- require("feline").statuscolumn.setup() -- to use statuscolumn
      require("feline").use_theme(clrs)
    end,
  },
}
