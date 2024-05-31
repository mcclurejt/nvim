return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    size = 35,
    open_mapping = [[<c-cr>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = false,
    -- shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
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
  },
}
