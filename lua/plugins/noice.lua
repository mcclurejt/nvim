return {
  "folke/noice.nvim",
  dependencies = {
    {
      "rcarriga/nvim-notify",
      opts = {
        render = "compact",
      },
    },
    { "hrsh7th/nvim-cmp" },
  },
  opts = {
    presets = {
      lsp_doc_border = false,
      bottom_search = false,
      command_palette = true,
    },
    notify = {
      format = "notify",
    },
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
      },
    },
  },
}
