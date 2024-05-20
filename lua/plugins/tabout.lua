return {
  "abecodes/tabout.nvim",
  config = function()
    require("tabout").setup({})
  end,
  dependencies = { -- These are optional
    "nvim-treesitter/nvim-treesitter",
    {
      "L3MON4D3/LuaSnip",
      keys = function()
        -- Disable default tab keybinding in LuaSnip
        return {}
      end,
    },
    "hrsh7th/nvim-cmp",
  },
}
