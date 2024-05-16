local package = require('core.pack').package

package({
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    config = function()
      require('modules.completion.lsp-zero')
    end,
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      {
        'neovim/nvim-lspconfig',
        dependencies = {
          {
            'SmiteshP/nvim-navbuddy',
            dependencies = {
              {
                'SmiteshP/nvim-navic',
                config = function()
                  -- vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
                  require('nvim-navic').setup({})
                end,
              },
              'MunifTanjim/nui.nvim',
            },
            opts = { lsp = { auto_attach = true } },
          },
        },
      },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/nvim-cmp' },
      { 'L3MON4D3/LuaSnip' },
      -- {
      --   'kevinhwang91/nvim-ufo',
      --   dependencies = {
      --     'kevinhwang91/promise-async',
      --   },
      --   config = function()
      --     require('ufo').setup({
      --       -- provider_selector = function(bufnr, filetype, buftype)
      --       --   return { 'treesitter', 'indent' }
      --       -- end,
      --       -- close_fold_kinds_for_ft = {
      --       --   default = { 'imports', 'comment' },
      --       -- },
      --       fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
      --         local hlgroup = 'NonText'
      --         local newVirtText = {}
      --         local suffix = '   ' .. tostring(endLnum - lnum)
      --         local sufWidth = vim.fn.strdisplaywidth(suffix)
      --         local targetWidth = width - sufWidth
      --         local curWidth = 0
      --         for _, chunk in ipairs(virtText) do
      --           local chunkText = chunk[1]
      --           local chunkWidth = vim.fn.strdisplaywidth(chunkText)
      --           if targetWidth > curWidth + chunkWidth then
      --             table.insert(newVirtText, chunk)
      --           else
      --             chunkText = truncate(chunkText, targetWidth - curWidth)
      --             local hlGroup = chunk[2]
      --             table.insert(newVirtText, { chunkText, hlGroup })
      --             chunkWidth = vim.fn.strdisplaywidth(chunkText)
      --             if curWidth + chunkWidth < targetWidth then
      --               suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      --             end
      --             break
      --           end
      --           curWidth = curWidth + chunkWidth
      --         end
      --         table.insert(newVirtText, { suffix, hlgroup })
      --         return newVirtText
      --       end,
      --     })
      --   end,
      -- },
    },
  },
})

package({
  'stevearc/conform.nvim',
  dependencies = {
    'mason.nvim',
  },
  config = function()
    local conf = require('conform')
    conf.setup({
      -- Map of filetype to formatters
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform will run multiple formatters sequentially
        go = { 'goimports', 'gofmt' },
        -- Use a sub-list to run only the first available formatter
        javascript = { { 'prettierd', 'prettier' } },
        typescript = { { 'prettierd', 'prettier' } },
        -- You can use a function here to determine the formatters dynamically
        python = function(bufnr)
          if require('conform').get_formatter_info('ruff_format', bufnr).available then
            return { 'ruff_format' }
          else
            return { 'isort', 'black' }
          end
        end,
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        ['_'] = { 'trim_whitespace' },
      },
      -- If this is set, Conform will run the formatter on save.
      -- It will pass the table to conform.format().
      -- This can also be a function that returns the table.
      format_on_save = {
        -- I recommend these options. See :help conform.format for details.
        lsp_fallback = false,
        timeout_ms = 5000,
      },
      -- If this is set, Conform will run the formatter asynchronously after save.
      -- It will pass the table to conform.format().
      -- This can also be a function that returns the table.
      format_after_save = {
        lsp_fallback = false,
      },
      -- Set the log level. Use `:ConformInfo` to see the location of the log file.
      log_level = vim.log.levels.ERROR,
      -- Conform will notify you when a formatter errors
      notify_on_error = true,
      -- Custom formatters and changes to built-in formatters
    })
  end,
})

package({
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = true,
  -- use opts = {} for passing setup options
  -- this is equalent to setup({}) function
})

package({
  'nvimdev/lspsaga.nvim',
  config = require('modules.completion.lspsaga'),
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
          winhighlight = 'Normal:CmpPmenu',
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
          item.menu = require('lspkind').cmp_format({ mode = 'symbol_text', maxwidth = 60 })(entry, item)
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
        ['<C-b>'] = cmp.mapping({
          c = function(fallback)
            if cmp.visible() then
              return cmp.scroll_docs(-4)
            end

            fallback()
          end,
        }),
        ['<C-f>'] = cmp.mapping({
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
  end,
})

-- package({
--   'nvimdev/guard.nvim',
--   dependencies = {
--     'nvimdev/guard-collection',
--   },
--   config = function()
--     local ft = require('guard.filetype')
--     local lint = require('guard.lint')

--     -- Typescript
--     ft('typescript,javascript,typescriptreact'):fmt('prettier')

--     -- Lua
--     ft('lua'):fmt('lsp'):append('stylua')

--     -- Rust
--     ft('rust'):fmt('rustfmt')

--     -- SQL
--     -- cargo install sleek
--     ft('sql'):fmt({
--       cmd = 'sleek',
--       stdin = true,
--     })

--     -- Shell
--     ft('sh'):fmt('shfmt')

--     require('guard').setup({
--       fmt_on_save = true,
--       lsp_as_default_formatter = false,
--     })
--   end,
-- })

-- TODO: Fix tsserver crashes
