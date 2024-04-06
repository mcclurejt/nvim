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
        delete = { text = '▎' },
        topdelete = { text = '▎' },
        changedelete = { text = '▎' },
      },
    })
  end,
})

-- NeoTree
-- package({
--   'nvim-neo-tree/neo-tree.nvim',
--   dependencies = {
--     'nvim-lua/plenary.nvim',
--     'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
--     'MunifTanjim/nui.nvim',
--     '3rd/image.nvim', -- Optional image support in preview window: See `# Preview Mode` for more information
--     'mrbjarksen/neo-tree-diagnostics.nvim', -- diagnostics view support
--   },
--   deactivate = function()
--     vim.cmd([[Neotree close]])
--   end,
--   init = function()
--     if vim.fn.argc(-1) == 1 then
--       ---@diagnostic disable-next-line: param-type-mismatch
--       local stat = vim.loop.fs_stat(vim.fn.argv(0))
--       if stat and stat.type == 'directory' then
--         require('neo-tree')
--       end
--     end
--   end,
--   config = conf.neo_tree,
-- })
-- package({
--   {
--     'antosha417/nvim-lsp-file-operations',
--     dependencies = {
--       'nvim-lua/plenary.nvim',
--       'nvim-neo-tree/neo-tree.nvim',
--     },
--     config = function()
--       require('lsp-file-operations').setup()
--     end,
--   },
-- })

-- Statusline
-- package({
--   'freddiehaddad/feline.nvim',
--   dependencies = {
--     'lewis6991/gitsigns.nvim',
--     'kyazdani42/nvim-web-devicons',
--   },
--   config = function()
--     local ctp_feline = require('catppuccin.groups.integrations.feline')
--
--     ctp_feline.setup({})
--
--     require('feline').setup({
--       components = ctp_feline.get(),
--     })
--     -- require('feline').winbar.setup({})
--     require('feline').statuscolumn.setup({})
--     require('feline').use_theme({})
--   end,
-- })

-- Noice
package({
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    -- 'rcarriga/nvim-notify',
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
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
      notify = {
        enabled = false,
      },
      message = {
        enabled = false,
      },
    })
  end,
})

-- Fidget
package({
  'j-hui/fidget.nvim',
  config = function()
    require('fidget').setup({
      integration = {
        ['nvim-tree'] = {
          enable = true, -- Integrate with nvim-tree/nvim-tree.lua (if installed)
        },
      },
    })
  end,
})

-- Mini.files
package({
  'echasnovski/mini.files',
  version = false,
  config = function()
    require('mini.files').setup({
      options = {
        use_as_default_explorer = false,
      },
    })
  end,
})

-- Mini.animate
-- package({
--   'echasnovski/mini.animate',
--   version = false,
--   config = function()
--     require('mini.animate').setup({})
--   end,
-- })

-- Heirline
package({
  'rebelot/heirline.nvim',
  dependencies = {
    'catppuccin/nvim',
    'nvim-lua/lsp-status.nvim',
  },
  config = require('modules.ui.heirline'),
})

-- Mini.clue
package({
  'echasnovski/mini.clue',
  version = false,
  config = function()
    local miniclue = require('mini.clue')
    miniclue.setup({
      {
        triggers = {
          -- Leader triggers
          { mode = 'n', keys = '<Leader>' },
          { mode = 'x', keys = '<Leader>' },

          -- Built-in completion
          { mode = 'i', keys = '<C-x>' },

          -- `g` key
          { mode = 'n', keys = 'g' },
          { mode = 'x', keys = 'g' },

          -- Marks
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = "'" },
          { mode = 'x', keys = '`' },

          -- Registers
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },

          -- Window commands
          { mode = 'n', keys = '<C-w>' },

          -- `z` key
          { mode = 'n', keys = 'z' },
          { mode = 'x', keys = 'z' },
        },

        clues = {
          -- Enhance this by adding descriptions for <Leader> mapping groups
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
        },
      },
    })
  end,
})

-- Telescope
package({
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  cmd = 'Telescope',
  -- init = function()
  --   require("core.utils").load_mappings "telescope"
  -- end,
  -- opts = function()
  --   return require "plugins.configs.telescope"
  -- end,
  config = require('modules.ui.telescope').setup,
})

-- StatusColumn
package({
  'luukvbaal/statuscol.nvim',
  config = function()
    -- local builtin = require("statuscol.builtin")
    require('statuscol').setup({
      -- configuration goes here, for example:
      -- relculright = true,
      -- segments = {
      --   { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
      -- {
      --   sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },
      --   click = "v:lua.ScSa"
      -- },
      --   { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
      --   {
      --     sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
      --     click = "v:lua.ScSa"
      --   },
      -- }
    })
  end,
})
