return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      actions = require("trouble.sources.snacks").actions,
      win = {
        input = {
          keys = {
            -- ["<esc>"] = { "close", mode = { "n", "i" } },
            ["<c-c>"] = "close",
            ["<c-t>"] = {
              "trouble_open",
              mode = { "n", "i" },
            },
          },
        },
      },
    },
  },
  keys = {
    {
      "<leader><space>",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep (Root Dir)",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Find Files",
    },
    {
      ",,",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Buffers",
    },
  },
}
