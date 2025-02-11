return {
  {
    "echasnovski/mini.diff",
    version = false,
    lazy = false,
    opts = {
      view = { style = "number" },
    },
    keys = {
      {
        "<CR>",
        function()
          MiniDiff.toggle_overlay()
        end,
      },
      {
        "ghn",
        function()
          MiniDiff.goto_hunk("next")
        end,
      },
      {
        "ghp",
        function()
          MiniDiff.goto_hunk("prev")
        end,
      },
    },
  },
  {
    "echasnovski/mini.jump",
    version = false,
    opts = true,
    enabled = false,
  },
  -- {
  --   "echasnovski/mini-git",
  --   config = function()
  --     require("mini.git").setup({})
  --   end,
  -- },
  {
    "echasnovski/mini.tabline",
    dependencies = {
      { "echasnovski/mini.icons", opts = {} },
    },
    version = false,
    enabled = false,
    opts = {
      tabpage_section = "left",
      set_vim_settings = true,
      show_icons = true,
    },
  },
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    enabled = false,
    event = "LazyFile",
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "alpha",
          "dashboard",
          "fzf",
          "help",
          "lazy",
          "lazyterm",
          "mason",
          "neo-tree",
          "notify",
          "toggleterm",
          "Trouble",
          "trouble",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
  -- {
  --   "echasnovski/mini.statusline",
  --   version = false,
  --   opts = {},
  -- },
  {
    "echasnovski/mini.hipatterns",
    version = false,
    opts = {
      highlighters = {
        author = { pattern = "@author", group = "@define" },
        title = { pattern = "@title", group = "@define" },
        disclaimer = { pattern = "@custom:[%w]*", group = "@define" },
        notice = { pattern = "@notice", group = "@define" },
        dev = { pattern = "@dev", group = "@define" },
        param = { pattern = "@param [%w]*", group = "@field" },
        returns = { pattern = "@return", group = "@error" },
        returns2 = { pattern = "@return [%l][%w]*", group = "@error" },
        returns3 = { pattern = "@return _[%w]*", group = "@error" },
        returns4 = { pattern = "@return [%w]_[%s]", group = "@error" },
      },
    },
  },
}
