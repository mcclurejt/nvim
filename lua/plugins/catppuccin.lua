return {
  "catppuccin/nvim",
  priority = 100000,
  config = function()
    require("catppuccin").setup({
      dim_inactive = {
        enabled = true,
      },
      transparent_background = false,
      term_colors = true,
      integrations = {
        aerial = true,
        alpha = true,
        barbar = true,
        colorful_winsep = {
          enabled = false,
          color = "mauve",
        },
        cmp = true,
        dashboard = true,
        diffview = true,
        flash = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true, scope_color = "rosewater", colored_indent_levels = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = {
          enabled = true,
        },
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        neogit = true,
        neotest = true,
        neotree = true,
        nvimtree = true,
        window_picker = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        ufo = true,
        which_key = true,
      },
      custom_highlights = function(colors)
        return {
          TelescopeNormal = {
            bg = colors.mantle,
          },
          -- -- NvimTree
          NvimTreeModifiedIcon = {
            fg = colors.peach,
            style = { "undercurl" },
          },
          NvimTreeGitDirtyIcon = {
            fg = colors.blue,
          },
          NvimTreeGitNewIcon = {
            fg = colors.green,
          },
          NvimTreeGitStagedIcon = {
            fg = colors.flamingo,
          },
          NvimTreeFolderName = {
            fg = colors.text,
            style = { "bold" },
          },
          NvimTreeOpenedFolderName = {
            fg = colors.text,
            style = { "bold" },
          },
          -- -- Enhance float titles
          -- FloatTitle = {
          --   fg = colors.text,
          -- },
          -- Noice Cmdline
          NoiceCmdlinePopupTitle = {
            fg = colors.text,
          },
          NoiceCmdlineIcon = {
            fg = colors.peach,
          },
          NoiceCmdlinePopupBorder = {
            fg = colors.peach,
          },
          -- Noice Search
          NoiceCmdlineIconSearch = {
            fg = colors.mauve,
          },
          NoiceCmdlinePopupBorderSearch = {
            fg = colors.mauve,
          },
          MiniDiffSignAdd = {
            link = "@diff.plus",
          },
          MiniDiffSignChange = {
            link = "@diff.delta",
          },
          MiniDiffSignDelete = {
            link = "@diff.minus",
          },
          GitSignsChange = {
            link = "@diff.delta",
          },
          MiniTablineCurrent = {
            fg = colors.base,
            bg = colors.blue,
            style = { "bold", "italic" },
          },
          MiniTablineVisible = {
            bg = colors.base,
            fg = colors.blue,
            style = { "bold" },
          },
          MiniTablineHidden = {
            fg = colors.surface2,
          },
          MiniTablineModifiedCurrent = {
            fg = colors.peach,
          },
          MiniTablineModifiedVisible = {
            fg = colors.peach,
          },
          MiniTablineModifiedHidden = {
            fg = colors.peach,
          },

          Pmenu = { fg = colors.overlay2, bg = colors.none or colors.base },
          PmenuBorder = { fg = colors.surface1, bg = colors.none or colors.base },
          PmenuSel = { bg = colors.green, fg = colors.base },
          CmpItemAbbr = { fg = colors.overlay2 },
          CmpItemAbbrMatch = { fg = colors.blue, style = { "bold" } },
          CmpDoc = { link = "NormalFloat" },
          CmpDocBorder = {
            fg = colors.surface1 or colors.mantle,
            bg = colors.none or colors.mantle,
          },
        }
      end,
    })
  end,
}
