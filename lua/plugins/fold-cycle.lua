return {
  "jghauser/fold-cycle.nvim",
  enabled = true,
  keys = {
    {
      "zk",
      function()
        require("fold-cycle").open_all()
      end,
    },
    {
      "zj",
      function()
        require("fold-cycle").close_all()
      end,
    },
  },
  opts = {
    open_if_max_closed = false,
  },
}
