return {
  "akinsho/toggleterm.nvim",
  enabled = false,
  version = "*",
  opts = {
    size = 30,
    open_mapping = [[<c-cr>]],
    hide_numbers = true,
    shade_filetypes = { "none", "fzf" },
    shade_terminals = false,
    -- shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    auto_scroll = false,
    direction = "horizontal",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = "curved",
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
    winbar = {
      enabled = true,
    },
  },
}
