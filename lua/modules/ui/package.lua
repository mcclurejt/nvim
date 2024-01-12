local package = require('core.pack').package
local conf = require('modules.ui.config')

-- Colorscheme
package({
  'catppuccin/nvim',
  lazy = false,
  priority = 1000,
  config = conf.catppuccin,
})

-- Indent Guides
package({
  'lukas-reineke/indent-blankline.nvim',
  dependencies = { 'catppuccin/nvim', 'HiPhish/rainbow-delimiters.nvim' },
  main = 'ibl',
  config = conf.indent_blankline,
})

-- Gitsigns
package({
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup({
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '➤' },
        topdelete = { text = '➤' },
        changedelete = { text = '▎' },
      },
    })
  end,
})

-- NeoTree
package({
  'nvim-neo-tree/neo-tree.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',          -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    '3rd/image.nvim',                       -- Optional image support in preview window: See `# Preview Mode` for more information
    'mrbjarksen/neo-tree-diagnostics.nvim', -- diagnostics view support
  },
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
  init = function()
    if vim.fn.argc(-1) == 1 then
      ---@diagnostic disable-next-line: param-type-mismatch
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == 'directory' then
        require('neo-tree')
      end
    end
  end,
  config = conf.neo_tree,
})
package({
  {
    'antosha417/nvim-lsp-file-operations',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-neo-tree/neo-tree.nvim',
    },
    config = function()
      require('lsp-file-operations').setup()
    end,
  },
})

-- Statusline
package({
  'freddiehaddad/feline.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'kyazdani42/nvim-web-devicons',
  },
  config = function()
    local ctp_feline = require('catppuccin.groups.integrations.feline')

    ctp_feline.setup({})

    require('feline').setup({
      components = ctp_feline.get(),
    })
    -- require('feline').winbar.setup({})
    require('feline').statuscolumn.setup({})
    require('feline').use_theme({})
  end,
})

-- Noice
package( -- lazy.nvim
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },

    config = function()
      require('noice').setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true,
          },
          progress = {
            enabled = false,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = false,        -- use a classic bottom cmdline for search
          command_palette = true,       -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false,           -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false,       -- add a border to hover docs and signature help
        },
        notify = {
          enabled = false,
        },
        message = {
          enabled = false,
        },
      })
    end,
  }
)

-- Fidget
package({
  'j-hui/fidget.nvim',
  config = function()
    require('fidget').setup({})
  end,
})

-- Lazygit
package({
  'kdheepak/lazygit.nvim',
})

-- Mini.files
package({
  'echasnovski/mini.files',
  version = false,
  config = function()
    require('mini.files').setup({
      options = {
        use_as_default_explorer = false
      }
    })
  end,
})
