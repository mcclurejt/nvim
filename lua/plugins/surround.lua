return {
  "kylechui/nvim-surround",
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      move_cursor = "end",
      aliases = {
        ["a"] = ">",
        ["b"] = { ")", "}", "]" },
        ["c"] = "}",
        ["p"] = ")",
        ["q"] = '"',
        ["r"] = "]",
        ["'"] = { '"', "'", "`" },
        ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
      },
      surrounds = {
        ["f"] = false,
      },
      keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "s",
        normal_cur = "ss",
        normal_line = "S",
        normal_cur_line = "SS",
        visual = "s",
        visual_line = "gs",
        delete = "ds",
        change = "cs",
        change_line = "cS",
      },
    })
  end,
}
