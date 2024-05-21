return {
  "neovim/nvim-lspconfig",
  init = function()
    require("lazyvim.util").lsp.on_attach(function(client, buffer)
      require("workspace-diagnostics").populate_workspace_diagnostics(client, buffer)
    end)

    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = { "gx", "<cmd>Lspsaga show_line_diagnostics<cr>", desc = "Line Diagnostics" }
    -- keys[#keys + 1] = { "<c-space>", "<cmd>lua vim.lsp.buf.omnifunc()<cr>", desc = "Auto-Complete" }
    keys[#keys + 1] = { "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "Next Diagnostic" }
    keys[#keys + 1] = { "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "Prev Diagnostic" }
    keys[#keys + 1] = { "K", "<cmd>Lspsaga hover_doc<cr>", desc = "Hover Docs" }
    keys[#keys + 1] = { "ga", "<cmd>Lspsaga code_action<cr>", desc = "Code Action" }
    keys[#keys + 1] = { "gd", "<cmd>Lspsaga peek_definition<cr>", desc = "Peek Definition" }
    keys[#keys + 1] = { "gD", "<cmd>Lspsaga goto_definition<cr>", desc = "Goto Definition" }
    keys[#keys + 1] = { "gy", "<cmd>Lspsaga peek_type_definition<cr>", desc = "Peek Type Definition" }
    keys[#keys + 1] = { "gr", "<cmd>Lspsaga rename<cr>", desc = "Rename" }
    keys[#keys + 1] = { "gm", "<cmd>Lspsaga finder<cr>", desc = "Peek Refs/Impls" }
  end,
  dependencies = {
    "artemave/workspace-diagnostics.nvim",
  },
  opts = {
    diagnostics = {
      underline = true,
      virtual_text = false,
    },
    inlay_hints = {
      enabled = false,
    },
  },
}
