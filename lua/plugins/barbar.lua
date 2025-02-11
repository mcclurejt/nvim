return {
  "romgrk/barbar.nvim",
  lazy = false,
  enabled = false,
  dependencies = {
    "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
    "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    clickable = false,
    insert_at_end = false,
    maximum_padding = 2,
    minimum_padding = 2,
    icons = {
      button = "",
      pinned = { filename = true, button = " " },
      filetype = { custom_colors = false, enabled = true },
      separator = {
        separator_at_end = true,
        right = " ",
      },
    },
  },
  keys = {
    {
      "<tab>",
      "<Cmd>BufferNext<CR>",
      desc = "Next Buffer",
    },
    {
      "<s-tab>",
      "<Cmd>BufferPrevious<CR>",
      desc = "Previous Buffer",
    },
    { "<leader>b<", "<Cmd>BufferMovePrevious<CR>", desc = "Move Buffer Left" },
    { "<leader>b>", "<Cmd>BufferMoveNext<CR>", desc = "Move Buffer Right" },
    { "<leader>bl", "<Cmd>BufferCloseBuffersLeft<CR>", desc = "Close Buffers Left of Current" },
    { "<leader>br", "<Cmd>BufferCloseBuffersRight<CR>", desc = "Close Buffers Right of Current" },
    { "<leader>bo", "<Cmd>BufferCloseAllButCurrent<CR>", desc = "Close Other Buffers" },
    { "<leader>bp", "<Cmd>BufferPin<CR>", desc = "Pin Buffer" },
    { "<leader>bP", "<Cmd>BufferPick<CR>", desc = "Pick Buffer" },
    { "<leader>bw", "<Cmd>BufferOrderByWindowNumber<CR>", desc = "Order Buffers by Window Number" },
    { "<leader>bn", "<Cmd>BufferOrderByBufferNumber<CR>", desc = "Order Buffers by Buffer Number" },
    { "<c-p>", "<Cmd>BufferPin<CR>", desc = "Pin Buffer Buffer" },
  },
}
