return {
  {
    "pmizio/typescript-tools.nvim",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "neovim/nvim-lspconfig",
        opts = function(_, opts)
          opts.servers.tsserver.root_dir = require("lspconfig").util.root_pattern({ ".git" })
          opts.servers.tailwindcss.root_dir = require("lspconfig").util.root_pattern({ ".git" })
          return opts
        end,
      },
    },
    opts = function(_, opts)
      opts.root_dir = require("lspconfig").util.root_pattern({ ".git" })
      opts.settings = { tsserver_plugins = { "@monodon/typescript-nx-imports-plugin" } }
      return opts
    end,
  },
}
