return {
  "saghen/blink.cmp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    -- add blink.compat to dependencies
    { "saghen/blink.compat", opts = {} },
    "mikavilpas/blink-ripgrep.nvim",
  },
  opts = {
    keymap = {
      preset = "super-tab",
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<ESC>"] = { "hide", "fallback" },
      ["<C-c>"] = { "hide", "fallback" },
      -- ["<Tab>"] = {
      --   "accent",
      --   "snippet_forward",
      --   "fallback",
      -- },
      ["<CR>"] = {
        "accept",
        "snippet_forward",
        "fallback",
      },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },
    -- sources = {
    --   completion = {
    --     enabled_providers = {
    --       "lsp",
    --       "path",
    --       "snippets",
    --       "buffer",
    --       -- "ripgrep", -- 👈🏻 add "ripgrep"
    --     },
    --   },
    --   providers = {
    --     -- 👇🏻👇🏻 add the ripgrep provider
    --     ripgrep = {
    --       module = "blink-ripgrep",
    --       name = "Ripgrep",
    --       -- the options below are optional, some default values are shown
    --       ---@module "blink-ripgrep"
    --       ---@type blink-ripgrep.Options
    --       opts = {
    --         -- the minimum length of the current word to start searching
    --         -- (if the word is shorter than this, the search will not start)
    --         prefix_min_len = 3,
    --         -- The number of lines to show around each match in the preview window
    --         context_size = 5,
    --       },
    --     },
    --   },
    -- },
    -- nerd_font_variant = "normal",
    -- -- experimental auto-brackets support
    -- accept = { auto_brackets = { enabled = true } },
    --
    -- -- experimental signature help support
    -- trigger = { signature_help = { enabled = true } },
    -- windows = {
    --   autocomplete = {
    --     draw = {
    --       columns = {
    --         {
    --           "label",
    --           "label_description",
    --           gap = 1,
    --         },
    --         {
    --           "kind_icon",
    --           "kind",
    --         },
    --       },
    --     },
    --   },
    -- },
  },
}
