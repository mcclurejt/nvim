return {
  "folke/noice.nvim",
  dependencies = {
    {
      "rcarriga/nvim-notify",
      opts = {
        render = "compact",
      },
    },
  },
  opts = {
    presets = {
      lsp_doc_border = true,
      bottom_search = false,
      command_palette = true,
    },
    notify = {
      format = "notify",
    },
  },
}
