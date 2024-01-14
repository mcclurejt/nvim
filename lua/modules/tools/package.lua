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
