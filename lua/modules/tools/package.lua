local package = require('core.pack').package
local conf = require('modules.tools.config')

-- TermToggle
package({
  'akinsho/toggleterm.nvim',
  version = '*',
  lazy = false,
  opts = {
    size = 120,
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    close_on_exit = false,
    shell = vim.o.shell,
    direction = 'float',
    float_opts = {
      border = 'curved', -- like `size`, width and height can be a number or function which is passed the current terminal
      winblend = 0,
      highlights = {
        border = 'Normal',
        background = 'Normal',
      },
      zindex = 1000,
    },
  },
  keys = {
    { '<C-CR>', mode = { 'n', 'i', 't' }, '<cmd>ToggleTerm<cr>', desc = 'Toggle Terminal' },
  },
})

-- fm-nvim (term-based programs)
package({ 'is0n/fm-nvim', config = conf.fm })

-- neogit
package({
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    {
      'sindrets/diffview.nvim',
      cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
    }, -- optional - Diff integration
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('neogit').setup({
      integrations = {
        telescope = true,
        diffview = true,
      },
    })
  end,
})

-- trouble
package({
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {},
})

-- todos
package({
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {},
})

package({
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
})

-- TODO: try tinygit
