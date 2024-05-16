local package = require('core.pack').package
local conf = require('modules.tools.config')

-- TermToggle
-- package({
--   'akinsho/toggleterm.nvim',
--   version = '*',
--   lazy = false,
--   opts = {
--     size = 120,
--     hide_numbers = true,
--     shade_filetypes = {},
--     shade_terminals = true,
--     shading_factor = 2,
--     start_in_insert = true,
--     insert_mappings = true,
--     persist_size = true,
--     close_on_exit = false,
--     shell = vim.o.shell,
--     direction = 'float',
--     float_opts = {
--       border = 'curved', -- like `size`, width and height can be a number or function which is passed the current terminal
--       winblend = 0,
--       highlights = {
--         border = 'Normal',
--         background = 'Normal',
--       },
--       zindex = 1000,
--     },
--   },
--   keys = {
--     { '<C-CR>', mode = { 'n', 'i', 't' }, '<cmd>ToggleTerm<cr>', desc = 'Toggle Terminal' },
--   },
-- })

-- fm-nvim (term-based programs)
package({ 'is0n/fm-nvim', config = conf.fm })

-- diffview
package({
  'sindrets/diffview.nvim',
  version = '*',
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewFileHistory' },
  opts = {
    {
      -- enhanced_diff_hl = true,
      view = {
        default = { winbar_info = true },
        file_history = { winbar_info = true, layout = 'diff1_plain' },
      },
      -- hooks = {
      --   diff_buf_read = function(bufnr)
      --     vim.b[bufnr].view_activated = false
      --   end,
      -- },
    },
  },
})

-- neogit
package({
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'nvim-telescope/telescope.nvim',
    'sindrets/diffview.nvim',
  },
  -- branch = 'nightly',
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

package({ 'alexghergh/nvim-tmux-navigation' })

package({
  'adigitoleo/haunt.nvim',
  config = function()
    require('haunt').setup({
      window = {
        width_frac = 0.7,
        height_frac = 0.7,
        winblend = 5,
        title_pos = 'center',
      },
    })
  end,
})

-- hover doc
-- package({
--   'LukasPietzschmann/boo.nvim',
--   opts = {
--     -- here goes your config :)
--   },
-- })

-- TODO: try tinygit
