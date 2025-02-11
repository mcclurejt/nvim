return {
  "catppuccin/nvim",
  enabled = true,
  priority = 100000,
  config = function()
    require("catppuccin").setup({
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.1, -- percentage of the shade to apply to the inactive window
      },
      show_end_of_buffer = true,
      transparent_background = false,
      term_colors = true,
      integrations = {
        aerial = true,
        alpha = true,
        barbar = true,
        blink_cmp = true,
        colorful_winsep = {
          enabled = true,
          color = "lavender",
        },
        cmp = true,
        dashboard = true,
        diffview = true,
        flash = true,
        fzf = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true, scope_color = "rosewater", colored_indent_levels = true },
        leap = true,
        lsp_trouble = true,
        lsp_saga = true,
        mason = true,
        markdown = true,
        mini = {
          enabled = false,
          indentscope_color = "rosewater",
        },
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
          inlay_hints = {
            background = true,
          },
        },
        navic = {
          enabled = true,
          custom_bg = "NONE",
        },
        neogit = true,
        dadbod_ui = true,
        neotest = true,
        neotree = true,
        nvimtree = true,
        nvim_surround = true,
        window_picker = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = {
          enabled = true,
          style = "nvchad",
        },
        treesitter = true,
        treesitter_context = true,
        ufo = true,
        which_key = true,
      },
      custom_highlights = function(colors)
        local utils = require("catppuccin.utils.colors")
        local inactive_color = utils.blend(colors.blue, colors.base, 0.7)
        local inactive_color2 = utils.blend(colors.pink, colors.base, 0.5)
        return {
          FloatBorder = {
            fg = colors.overlay2,
          },
          FloatTitle = {
            fg = colors.mauve,
          },
          FzfLuaFzfHeader = {
            fg = colors.blue,
          },
          -- TelescopeNormal = {
          --   bg = colors.mantle,
          -- },
          TelescopeMatching = { fg = colors.flamingo },
          TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },
          TelescopePromptPrefix = { bg = colors.surface0 },
          TelescopePromptNormal = { bg = colors.surface0 },
          TelescopeResultsNormal = { bg = colors.mantle },
          TelescopePreviewNormal = { bg = colors.mantle },
          TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
          TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
          TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
          TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
          TelescopeResultsTitle = { fg = colors.mantle },
          TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
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
            -- style = { "bold" },
          },
          NvimTreeFolderIcon = {
            fg = colors.rosewater,
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
          -- NoiceCmdlinePopupTitle = {
          --   fg = colors.text,
          -- },
          -- NoiceCmdlineIcon = {
          --   fg = colors.peach,
          -- },
          -- NoiceCmdlinePopupBorder = {
          --   fg = colors.peach,
          -- },
          -- -- Noice Search
          -- NoiceCmdlineIconSearch = {
          --   fg = colors.mauve,
          -- },
          -- NoiceCmdlinePopupBorderSearch = {
          --   fg = colors.mauve,
          -- },
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
            bg = colors.mauve,
            style = { "bold" },
          },
          MiniTablineVisible = {
            bg = colors.base,
            fg = colors.mauve,
            style = {},
          },
          MiniTablineHidden = {
            fg = colors.surface2,
            bg = colors.mantle,
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
          MiniTablineFill = {
            bg = colors.mantle,
          },
          NvimTreeWindowPicker = {
            fg = colors.base,
            bg = colors.red,
            style = { "bold" },
          },
          -- Barbar
          BufferCurrent = {
            fg = colors.text,
            bg = colors.base,
          },
          BufferCurrentSign = {
            bg = colors.pink,
            fg = colors.mantle,
          },
          BufferCurrentSignRight = {
            bg = colors.pink,
            fg = colors.mantle,
          },
          BufferCurrentIcon = {
            fg = colors.blue,
            bg = colors.base,
          },
          BufferCurrentPinBtn = {
            fg = colors.pink,
            bg = colors.base,
          },
          BufferCurrentMod = {
            fg = colors.peach,
            bg = colors.base,
            style = { "bold" },
          },
          BufferCurrentModBtn = {
            fg = colors.peach,
            bg = colors.base,
          },
          BufferVisible = {
            fg = colors.overlay0,
            bg = colors.base,
          },
          BufferVisibleSign = {
            bg = inactive_color,
            fg = colors.base,
          },
          BufferVisibleSignRight = {
            bg = inactive_color,
            fg = colors.mantle,
          },
          BufferVisibleIcon = {
            fg = inactive_color,
            bg = colors.base,
          },
          BufferVisiblePinBtn = {
            fg = colors.pink,
            bg = colors.base,
          },
          BufferVisibleMod = {
            fg = colors.peach,
            bg = colors.base,
            style = { "bold", "undercurl" },
          },
          BufferInactive = {
            fg = colors.overlay0,
            bg = colors.mantle,
          },
          BufferInactiveSign = {
            bg = colors.mantle,
            fg = colors.overlay0,
          },
          BufferInactiveSignRight = {
            bg = colors.mantle,
            fg = colors.overlay0,
          },
          -- BufferInactiveIcon = {
          --   fg = colors.mauve,
          --   bg = colors.base,
          -- },
          BufferInactivePinBtn = {
            fg = colors.pink,
            bg = colors.base,
          },
          BufferInactiveMod = {
            fg = colors.peach,
            bg = colors.base,
            style = { "bold" },
          },
          BufferInactiveModBtn = {
            fg = colors.peach,
            bg = colors.base,
          },
          -- BufferCurrentModBtn = {
          --   fg = colors.peach,
          --   bg = colors.base,
          --   style = { "bold" },
          -- },
          LeapMatch = {
            fg = colors.pink,
            style = { "underline", "nocombine", "bold" },
          },
          LeapBackdrop = {
            fg = colors.overlay0,
          },
          IndentLine = {
            fg = colors.surface2,
          },
          IndentLineCurrent = {
            fg = colors.rosewater,
          },
        }
      end,
    })
  end,
}
