return {
  "nvimtools/none-ls.nvim",
  dependencies = { "mason.nvim", "artemave/workspace-diagnostics.nvim" },
  opts = function(_, opts)
    local nls = require("null-ls")
    opts.sources = vim.list_extend(opts.sources or {}, {
      nls.builtins.formatting.prettierd.with({
        prefer_local = "node_modules/.bin",
      }),
      nls.builtins.diagnostics.solhint,
    })
    opts.on_attach = function(client, buffer)
      require("workspace-diagnostics").populate_workspace_diagnostics(client, buffer)
    end
  end,
}
