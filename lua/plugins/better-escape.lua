return {
  "max397574/better-escape.nvim",
  commit = "7e86edafb8c7e73699e0320f225464a298b96d12",
  opts = {
    mapping = { "jk", "kj" },
    keys = function()
      return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<esc>l" or "<esc>"
    end,
  },
}
