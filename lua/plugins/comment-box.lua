return {
  "LudoPinelli/comment-box.nvim",
  keys = {
    { "<leader>h1", "<cmd>CBlcbox1<cr>", desc = "Box (centered)", mode = { "n", "x" } },
    { "<leader>h2", "<cmd>CBllbox1<cr>", desc = "Box (left aligned)", mode = { "n", "x" } },
    { "<leader>h3", "<cmd>CBlcline1<cr>", desc = "Line (centered)", mode = { "n", "x" } },
    { "<leader>h4", "<cmd>CBllline1<cr>", desc = "Line (left aligned)", mode = { "n", "x" } },
  },
  opts = {
    box_width = 74,
    line_width = 70,
  },
}
