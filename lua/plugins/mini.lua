return {
  -- {
  --   "echasnovski/mini.diff",
  --   version = false,
  --   opts = {
  --     view = { style = "number" },
  --   },
  -- },
  {
    "echasnovski/mini.jump",
    version = false,
    opts = true,
  },
  {
    "echasnovski/mini-git",
    config = function()
      require("mini.git").setup({})
    end,
  },
  -- {
  --   "echasnovski/mini.tabline",
  --   version = false,
  --   opts = {
  --     tabpage_section = "left",
  --   },
  -- },
  -- {
  --   "echasnovski/mini.statusline",
  --   version = false,
  --   opts = {},
  -- },
}
