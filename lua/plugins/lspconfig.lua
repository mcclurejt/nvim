return {
  {
    "neovim/nvim-lspconfig",
    -- init = function()
    -- require("lazyvim.util").lsp.on_attach(require("workspace-diagnostics").populate_workspace_diagnostics)
    -- end,
    enabled = true,
    dependencies = {
      "nvimdev/lspsaga.nvim",
      -- "artemave/workspace-diagnostics.nvim",
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          {
            "SmiteshP/nvim-navic",
            opts = {
              lsp = {
                auto_attach = true,
              },
            },
          },
          "MunifTanjim/nui.nvim",
        },
        opts = {
          highlight = true,
          lsp = {
            auto_attach = true,
          },
          window = {
            size = {
              width = "70%",
              height = "80%",
            },
            border = "rounded",
            scrolloff = 10,
            sections = {
              left = {
                size = "20%",
                border = nil, -- You can set border style for each section individually as well.
              },
              mid = {
                size = "30%",
                border = nil,
              },
              right = {
                -- No size option for right most section. It fills to
                -- remaining area.
                border = nil,
                preview = "always", -- Right section can show previews too.
                -- Options: "leaf", "always" or "never"
              },
            },
          },
          source_buffer = {
            follow_node = false, -- Keep the current node in focus on the source buffer
            highlight = true, -- Highlight the currently focused node
            reorient = "smart", -- "smart", "top", "mid" or "none"
            scrolloff = nil, -- scrolloff value when navbuddy is open
          },
        },
        keys = {
          { "<leader>o", "<CMD>Navbuddy<CR>", desc = "Document Symbols" },
        },
      },
    },
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "gx", "<cmd>Lspsaga show_line_diagnostics<cr>" }
      keys[#keys + 1] = { "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>" }
      keys[#keys + 1] = { "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>" }
      keys[#keys + 1] = { "K", "<cmd>Lspsaga hover_doc<cr>" }
      -- keys[#keys + 1] = { "K", vim.lsp.buf.hover }
      keys[#keys + 1] = { "ga", "<cmd>Lspsaga code_action<cr>" }
      keys[#keys + 1] = { "gd", "<cmd>Lspsaga peek_definition<cr>" }
      -- keys[#keys + 1] = { "gd", vim.lsp.buf.definition }
      keys[#keys + 1] = { "gD", "<cmd>Lspsaga goto_definition<cr>" }
      keys[#keys + 1] = { "gy", "<cmd>Lspsaga peek_type_definition<cr>" }
      keys[#keys + 1] = { "gr", "<cmd>Lspsaga rename<cr>", desc = "Lspsaga Rename" }
      keys[#keys + 1] = { "gm", "<cmd>Lspsaga finder<cr>" }
    end,
    -- opts = function()
    --   local keys = require("lazyvim.plugins.lsp.keymaps").get()
    --   keys[#keys + 1] = { "gx", "<cmd>Lspsaga show_line_diagnostics<cr>" }
    --   keys[#keys + 1] = { "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>" }
    --   keys[#keys + 1] = { "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>" }
    --   -- keys[#keys + 1] = { "K", "<cmd>Lspsaga hover_doc<cr>" }
    --   -- keys[#keys + 1] = { "K", vim.lsp.buf.hover }
    --   keys[#keys + 1] = { "ga", "<cmd>Lspsaga code_action<cr>" }
    --   keys[#keys + 1] = { "gd", "<cmd>Lspsaga peek_definition<cr>" }
    --   -- keys[#keys + 1] = { "gd", vim.lsp.buf.definition }
    --   keys[#keys + 1] = { "gD", "<cmd>Lspsaga goto_definition<cr>" }
    --   keys[#keys + 1] = { "gy", "<cmd>Lspsaga peek_type_definition<cr>" }
    --   keys[#keys + 1] = { "gr", "<cmd>Lspsaga rename<cr>", desc = "Lspsaga Rename" }
    --   keys[#keys + 1] = { "gm", "<cmd>Lspsaga finder<cr>" }
    --   --   return {
    --   --     inlay_hints = {
    --   --       enabled = false,
    --   --     },
    --   --     diagnostics = {
    --   --       virtual_text = false,
    --   --       signs = {
    --   --         text = {
    --   --           [vim.diagnostic.severity.ERROR] = " ",
    --   --           [vim.diagnostic.severity.WARN] = " ",
    --   --           [vim.diagnostic.severity.HINT] = " ",
    --   --           [vim.diagnostic.severity.INFO] = " ",
    --   --         },
    --   --       },
    --   --     },
    --   --   }
    -- end,
  },
  {
    "neovim/nvim-lspconfig",
    -- init = function()
    --   require("lazyvim.util").lsp.on_attach(require("workspace-diagnostics").populate_workspace_diagnostics)
    -- end,
    dependencies = {
      "nvimdev/lspsaga.nvim",
    },
    opts = {
      inlay_hints = {
        enabled = false,
      },
      diagnostics = {
        virtual_text = false,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
      },
      servers = {
        -- solidity = {
        --   mason = false,
        --   root_pattern = require("lspconfig.util").root_pattern("foundry.toml", ".git"),
        -- },
        solidity_ls_nomicfoundation = {
          capabilities = {
            completionProvider = {
              triggerCharacters = { ".", "/", '"', "'", "*" },
            },
            signatureHelpProvider = {
              triggerCharacters = { "(", "," },
            },
            definitionProvider = true,
            typeDefinitionProvider = true,
            referencesProvider = true,
            implementationProvider = true,
            renameProvider = true,
            codeActionProvider = true,
            hoverProvider = true,
            documentFormattingProvider = true,
            documentSymbolProvider = true,
            workspace = {
              workspaceFolders = {
                supported = true,
                changeNotifications = true,
              },
            },
          },
        },
        -- solidity_ls = {
        --   capabilities = {
        --     completionProvider = false,
        --     signatureHelpProvider = false,
        --     definitionProvider = false,
        --     typeDefinitionProvider = false,
        --     referencesProvider = false,
        --     implementationProvider = false,
        --     renameProvider = false,
        --     codeActionProvider = false,
        --     hoverProvider = true,
        --     documentFormattingProvider = false,
        --     documentSymbolProvider = false,
        --   },
        -- },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "solhint", "prettierd" })
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["javascript"] = { "prettierd" },
        ["javascriptreact"] = { "prettierd" },
        ["typescript"] = { "prettierd" },
        ["typescriptreact"] = { "prettierd" },
        ["vue"] = { "prettierd" },
        ["css"] = { "prettierd" },
        ["scss"] = { "prettierd" },
        ["less"] = { "prettierd" },
        ["html"] = { "prettierd" },
        ["json"] = { "prettierd" },
        ["jsonc"] = { "prettierd" },
        ["yaml"] = { "prettierd" },
        ["markdown"] = { "prettierd" },
        ["markdown.mdx"] = { "prettierd" },
        ["graphql"] = { "prettierd" },
        ["handlebars"] = { "prettierd" },
        ["solidity"] = { "prettierd" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        solidity = { "solhint" },
      },
    },
  },
}
