local package = require('core.pack').package
local conf = require('modules.editor.config')

package({
  'nvim-treesitter/nvim-treesitter',
  event = 'BufRead',
  run = ':TSUpdate',
  config = conf.nvim_treesitter,
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
})

-- Flash (jumping)
-- https://github.com/folke/flash.nvim
package({
  'folke/flash.nvim',
  event = 'VeryLazy',
  config = function()
    require('flash').setup({})
  end,
  keys = {
    {
      's',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash',
    },
    {
      'S',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').treesitter()
      end,
      desc = 'Flash Treesitter',
    },
    {
      'r',
      mode = 'o',
      function()
        require('flash').remote()
      end,
      desc = 'Remote Flash',
    },
    {
      'R',
      mode = { 'o', 'x' },
      function()
        require('flash').treesitter_search()
      end,
      desc = 'Treesitter Search',
    },
    {
      '<c-s>',
      mode = { 'c' },
      function()
        require('flash').toggle()
      end,
      desc = 'Toggle Flash Search',
    },
  },
})

-- Mini.surround
package({
  'echasnovski/mini.surround',
  version = false,
  config = function()
    require('mini.surround').setup({
      search_method = 'cover_or_next',
      mappings = {
        add = 'gsa',            -- Add surrounding in Normal and Visual modes
        delete = 'gsd',         -- Delete surrounding
        find = 'gsf',           -- Find surrounding (to the right)
        find_left = 'gsF',      -- Find surrounding (to the left)
        highlight = 'gsh',      -- Highlight surrounding
        replace = 'gsr',        -- Replace surrounding
        update_n_lines = 'gsn', -- Update `n_lines`

        suffix_last = '',       -- Suffix to search with "prev" method
        suffix_next = '',       -- Suffix to search with "next" method
      },
    })
  end,
})

-- Mini.comment
package({
  'echasnovski/mini.comment',
  version = false,
  config = function()
    require('mini.comment').setup({})
  end,
})

-- Tabout
package({
  'abecodes/tabout.nvim',
  config = function()
    require('tabout').setup({})
  end,
})

-- Spider
package({
  'chrisgrieser/nvim-spider',
  lazy = true,
  keys = {
    {
      'w',
      "<cmd>lua require('spider').motion('w')<CR>",
      {
        'n',
        'o',
        'x',
      },
      desc = 'Spider-w',
    },
    {
      'e',
      "<cmd>lua require('spider').motion('e')<CR>",
      {
        'n',
        'o',
        'x',
      },
      desc = 'Spider-e',
    },
    {
      'b',
      "<cmd>lua require('spider').motion('b')<CR>",
      {
        'n',
        'o',
        'x',
      },
      desc = 'Spider-b',
    },
  },
})

-- Portal
package({
  'cbochs/portal.nvim',
  opts = {
    window_options = {
      border = 'rounded',
    },
  },
  keys = {
    {
      ']j',
      function()
        require('portal.builtin').jumplist.tunnel_forward()
      end,
      desc = 'Jump Forward',
    },
    {
      '[j',
      function()
        require('portal.builtin').jumplist.tunnel_backward()
      end,
      desc = 'Jump Backward',
    },
  },
})

-- Mini.basics
-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-basics.md
package({
  'echasnovski/mini.basics',
  version = false,
  config = function()
    require('mini.basics').setup({
      extra_ui = true,
      mappings = {
        windows = true,
      },
    })
  end,
})

-- Mini.bufremove
-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-bufremove.md
package({
  'echasnovski/mini.bufremove',
  version = false,
  config = function()
    require('mini.bufremove').setup({})
  end,
})

-- Persistence (sessions)
-- https://github.com/folke/persistence.nvim
package( -- Lua
  {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup({
        log_level = 'error',
        auto_session_suppress_dirs = { '~/', '~/src' },
      })
    end,
  }
)

-- Mini.ai (textobjects)
package({
  'echasnovski/mini.ai',
  version = false,
  config = function()
    require('mini.ai').setup({})
  end,
})

-- NvimTree
package({
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    {
      'yamatsum/nvim-nonicons',
      dependencies = { 'kyazdani42/nvim-web-devicons' },
    },
  },
  config = require('modules.editor.nvimtree').setup,
})
package({
  {
    'antosha417/nvim-lsp-file-operations',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-tree.lua',
    },
    config = function()
      require('lsp-file-operations').setup()
    end,
  },
})

-- Bracketed (do stuff with square brackets)
package({
  {
    'echasnovski/mini.bracketed',
    version = false,
    config = function()
      require('mini.bracketed').setup({
        buffer = { suffix = 'b', options = {} },
        comment = { suffix = 'c', options = {} },
        conflict = { suffix = 'x', options = {} },
        diagnostic = { suffix = 'd', options = {} },
        file = { suffix = 'f', options = {} },
        indent = { suffix = 'i', options = {} },
        jump = { suffix = 'j', options = {} },
        location = { suffix = 'l', options = {} },
        oldfile = { suffix = 'o', options = {} },
        quickfix = { suffix = 'q', options = {} },
        treesitter = { suffix = 't', options = {} },
        undo = { suffix = 'u', options = {} },
        window = { suffix = 'w', options = {} },
        yank = { suffix = 'y', options = {} },
      })
    end,
  },
})
