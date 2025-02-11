return {
  "lukas-reineke/indent-blankline.nvim",
  dependencies = { "catppuccin/nvim", "HiPhish/rainbow-delimiters.nvim" },
  main = "ibl",
  enabled = true,
  config = function()
    local p = require("catppuccin.palettes").get_palette("mocha")
    local hooks = require("ibl.hooks")
    local highlight = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
    }
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = p.red })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = p.yellow })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = p.blue })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = p.peach })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = p.green })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = p.lavender })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = p.sky })
    end)

    -- vim.g.rainbow_delimiters = { highlight = highlight }
    require("ibl").setup({
      indent = { char = "¦", smart_indent_cap = false },
      scope = { enabled = true, highlight = highlight, show_start = false },
      -- scope = { enabled = false },
      -- indent = {
      --   char = "┊", --[[ highlight = highlight ]]
      -- },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
          "NvimTree",
        },
      },
    })
    -- links highlights with rainbow-delimiters
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}
