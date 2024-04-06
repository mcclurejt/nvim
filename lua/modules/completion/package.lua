local package = require('core.pack').package

package({
  "mrcjkb/rustaceanvim",
  version = '^4', -- Recommended
  ft = { "rust" },
  -- opts = {
  --   server = {
  --     on_attach = function(client, bufnr)
  --       -- register which-key mappings
  --       local wk = require("which-key")
  --       wk.register({
  --         ["<leader>cR"] = { function() vim.cmd.RustLsp("codeAction") end, "Code Action" },
  --         ["<leader>dr"] = { function() vim.cmd.RustLsp("debuggables") end, "Rust debuggables" },
  --       }, { mode = "n", buffer = bufnr })
  --     end,
  --     default_settings = {
  --       -- rust-analyzer language server configuration
  --       ["rust-analyzer"] = {
  --         cargo = {
  --           allFeatures = true,
  --           loadOutDirsFromCheck = true,
  --           runBuildScripts = true,
  --         },
  --         -- Add clippy lints for Rust.
  --         checkOnSave = {
  --           allFeatures = true,
  --           command = "clippy",
  --           extraArgs = { "--no-deps" },
  --         },
  --         procMacro = {
  --           enable = true,
  --           ignored = {
  --             ["async-trait"] = { "async_trait" },
  --             ["napi-derive"] = { "napi" },
  --             ["async-recursion"] = { "async_recursion" },
  --           },
  --         },
  --       },
  --     },
  --   }
  -- },
  -- config = function(_, opts)
  --   vim.g.rustaceanvim = vim.tbl_deep_extend("force",
  --     {},
  --     opts or {})
  -- end
})

package({
  'neovim/nvim-lspconfig',
  event = 'BufReadPre',
  dependencies = {
    'folke/neodev.nvim',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'lewis6991/gitsigns.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'nvim-lua/lsp-status.nvim',
  },
  config = function()
    require('modules.completion.lspconfig')
  end,
})

package({
  'L3MON4D3/LuaSnip',
  event = 'InsertCharPre',
  dependencies = {
    { 'rafamadriz/friendly-snippets' },
  },
  config = function()
    local ls = require('luasnip')
    local types = require('luasnip.util.types')
    ls.config.set_config({
      history = true,
      enable_autosnippets = true,
      updateevents = 'TextChanged,TextChangedI',
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { '<- choiceNode', 'Comment' } },
          },
        },
      },
    })
    require('luasnip.loaders.from_lua').lazy_load({ paths = vim.fn.stdpath('config') .. '/snippets' })
    require('luasnip.loaders.from_vscode').lazy_load()
    require('luasnip.loaders.from_vscode').lazy_load({
      paths = { './snippets/' },
    })
  end,
})

package({
  'nvimdev/lspsaga.nvim',
  event = 'LspAttach',
  config = require('modules.completion.lspsaga'),
})

package({
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    require('nvim-autopairs').setup({})
  end,
})

package({
  'onsails/lspkind.nvim',
})

local lspkind_icons = {
  Namespace = '󰌗',
  Text = '󰉿',
  Method = '󰆧',
  Function = '󰆧',
  Constructor = '',
  Field = '󰜢',
  Variable = '󰀫',
  Class = '󰠱',
  Interface = '',
  Module = '',
  Property = '󰜢',
  Unit = '󰑭',
  Value = '󰎠',
  Enum = '',
  Keyword = '󰌋',
  Snippet = '',
  Color = '󰏘',
  File = '󰈚',
  Reference = '󰈇',
  Folder = '󰉋',
  EnumMember = '',
  Constant = '󰏿',
  Struct = '󰙅',
  Event = '',
  Operator = '󰆕',
  TypeParameter = '󰊄',
  Table = '',
  Object = '󰅩',
  Tag = '',
  Array = '[]',
  Boolean = '',
  Number = '',
  Null = '󰟢',
  String = '󰉿',
  Calendar = '',
  Watch = '󰥔',
  Package = '',
  Copilot = '',
  Codeium = '',
  TabNine = '',
}

package({
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-buffer' },
    { 'saadparwaiz1/cmp_luasnip' },
  },
  config = function()
    local luasnip = require('luasnip')
    local cmp = require('cmp')
    local select_opts = { behavior = cmp.SelectBehavior.Select }
    local function border(hl_name)
      return {
        { '╭', hl_name },
        { '─', hl_name },
        { '╮', hl_name },
        { '│', hl_name },
        { '╯', hl_name },
        { '─', hl_name },
        { '╰', hl_name },
        { '│', hl_name },
      }
    end

    cmp.setup({
      completion = {
        completeopt = 'menu,menuone',
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'nvim_lua' },
        { name = 'path' },
      },
      window = {
        completion = {
          side_padding = 1,
          -- winhighlight = 'Normal:CmpPmenu,CursorLine:CmpSel,Search:None',
          scrollbar = false,
          border = border('CmpBorder'),
        },
        documentation = {
          border = border('CmpDocBorder'),
          winhighlight = 'Normal:CmpDoc',
        },
      },
      ---@diagnostic disable-next-line: missing-fields
      formatting = {
        fields = { 'abbr', 'kind', 'menu' },
        format = function(entry, item)
          local icon = lspkind_icons[item.kind] or ''
          icon = ' ' .. icon .. ' '
          item.menu = require('lspkind').cmp_format({ mode = 'symbol_text', maxwidth = 50 })(entry, item)
              and '   (' .. item.kind .. ')'
              or ''
          item.kind = icon
          return item
        end,
      },
      -- See :help cmp-mapping
      mapping = {
        -- fire it up
        ['<c-space>'] = cmp.mapping.complete(),

        -- for the normies
        ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
        ['<Down>'] = cmp.mapping.select_next_item(select_opts),

        -- for the hardos
        ['<C-k>'] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() then
              return cmp.select_prev_item(select_opts)
            end

            fallback()
          end,
        }),
        ['<C-j>'] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() then
              return cmp.select_next_item(select_opts)
            end

            fallback()
          end,
        }),

        -- scrolling docs
        ['<C-u>'] = cmp.mapping({
          c = function(fallback)
            if cmp.visible() then
              return cmp.scroll_docs(-4)
            end

            fallback()
          end,
        }),
        ['<C-d>'] = cmp.mapping({
          c = function(fallback)
            if cmp.visible() then
              return cmp.scroll_docs(4)
            end

            fallback()
          end,
        }),

        -- hide it if it's irritating
        ['<C-c>'] = cmp.mapping.abort(),
        ['<ESC>'] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() then
              return cmp.abort()
            end
            fallback()
          end,
        }),
        ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),

        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
    })
    cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())

    -- -- null-ls
    -- local null_ls = require('null-ls')
    -- null_ls.setup({
    --   sources = {
    --     null_ls.builtins.completion.spell.with({
    --       filetypes = { 'markdown', 'text' },
    --     }),
    --     null_ls.builtins.formatting.stylua,
    --     null_ls.builtins.code_actions.gitsigns,
    --     null_ls.builtins.hover.dictionary,
    --     null_ls.builtins.hover.printenv,
    --     null_ls.builtins.formatting.codespell
    --   },
    -- })
  end,
})

package({
  'nvimdev/guard.nvim',
  dependencies = {
    'nvimdev/guard-collection',
  },
  config = function()
    local ft = require('guard.filetype')
    local lint = require('guard.lint')

    -- Typescript
    ft('typescript,javascript,typescriptreact'):fmt('prettier')

    -- Lua
    ft('lua'):fmt('lsp'):append('stylua')

    -- Rust
    ft('rust'):fmt('rustfmt')

    -- SQL
    -- cargo install sleek
    ft('sql'):fmt({
      cmd = 'sleek',
      stdin = true,
    })

    -- Shell
    ft('sh'):fmt('shfmt')

    require('guard').setup({
      fmt_on_save = true,
      lsp_as_default_formatter = true
    })
  end,
})

-- TODO: Fix tsserver crashes
