return {
  {
    "catppuccin/nvim",
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
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            -- underlines = {
            --   errors = { "undercurl" },
            --   hints = { "undercurl" },
            --   warnings = { "undercurl" },
            --   information = { "undercurl" },
            -- },
            inlay_hints = {
              background = false,
            },
          },
          navic = { enabled = true, custom_bg = "lualine" },
          neogit = true,
          neotest = true,
          neotree = true,
          nvimtree = true,
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
            -- NvimTree
            NvimTreeModifiedIcon = {
              fg = colors.flamingo,
            },
            NvimTreeModifiedFolderHL = {
              fg = colors.flamingo,
            },
            NvimTreeModifiedFileHL = {
              fg = colors.flamingo,
            },
            -- Enhance float titles
            FloatTitle = {
              fg = colors.text,
            },
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
          }
        end,
      })
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
      icons = {
        diagnostics = {
          Warn = " ",
          Error = " ",
          Hint = " ",
          Info = " ",
        },
        git = {
          added = " ",
          modified = " ",
          removed = " ",
        },
      },
    },
  },
}
