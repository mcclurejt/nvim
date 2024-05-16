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
    require('flash').setup({
      modes = {
        char = {
          jump_labels = true,
        },
      },
    })
  end,
  keys = {
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

-- package({
--   'phaazon/hop.nvim',
--   branch = 'v2',
--   config = function()
--     local hop = require('hop')
--     local directions = require('hop.hint').HintDirection
--     vim.keymap.set('', 'f', function()
--       hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
--     end, { remap = true })
--     vim.keymap.set('', 'F', function()
--       hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
--     end, { remap = true })
--     vim.keymap.set('', 't', function()
--       hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
--     end, { remap = true })
--     vim.keymap.set('', 'T', function()
--       hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
--     end, { remap = true })
--     require('hop').setup({})
--   end,
-- })

-- Mini.surround
-- package({
--   'echasnovski/mini.surround',
--   version = false,
--   config = function()
--     require('mini.surround').setup({
--       search_method = 'cover_or_next',
--       mappings = {
--         add = 'gsa', -- Add surrounding in Normal and Visual modes
--         delete = 'gsd', -- Delete surrounding
--         find = 'gsf', -- Find surrounding (to the right)
--         find_left = 'gsF', -- Find surrounding (to the left)
--         highlight = 'gsh', -- Highlight surrounding
--         replace = 'gsr', -- Replace surrounding
--         update_n_lines = 'gsn', -- Update `n_lines`
--
--         suffix_last = '', -- Suffix to search with "prev" method
--         suffix_next = '', -- Suffix to search with "next" method
--       },
--     })
--   end,
-- })

-- Nvim Surround
package({
  'kylechui/nvim-surround',
  event = 'VeryLazy',
  config = function()
    require('nvim-surround').setup({
      move_cursor = 'end',
      aliases = {
        ['a'] = '>',
        ['b'] = { ')', '}', ']' },
        ['c'] = '}',
        ['p'] = ')',
        ['q'] = '"',
        ['r'] = ']',
        ["'"] = { '"', "'", '`' },
        ['s'] = { '}', ']', ')', '>', '"', "'", '`' },
      },
      surrounds = {
        ['f'] = false,
      },
      keymaps = {
        insert = '<C-g>s',
        insert_line = '<C-g>S',
        normal = 's',
        normal_cur = 'ss',
        normal_line = 'S',
        normal_cur_line = 'SS',
        visual = 's',
        visual_line = 'gs',
        delete = 'ds',
        change = 'cs',
        change_line = 'cS',
      },
    })
  end,
})

package({
  'numToStr/Comment.nvim',
  opts = {
    ---Add a space b/w comment and the line
    padding = true,
    ---Whether the cursor should stay at its position
    sticky = true,
    ---Lines to be ignored while (un)comment
    ignore = nil,
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
      ---Line-comment toggle keymap
      line = 'gc',
      ---Block-comment toggle keymap
      block = 'gb',
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
      ---Line-comment keymap
      line = 'gc',
      ---Block-comment keymap
      block = 'gb',
    },
    ---Enable keybindings
    ---NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
      ---Operator-pending mapping; `gcc` `gbc` `gc'count'{motion}` `gb[count]{motion}`
      basic = true,
      ---Extra mapping; `gco`, `gcO`, `gcA`
      extra = false,
    },
    ---Function to call before (un)comment
    pre_hook = nil,
    ---Function to call after (un)comment
    post_hook = nil,
  },
  lazy = false,
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
      mode = {
        'n',
        'o',
        'x',
      },
      desc = 'Spider-w',
    },
    {
      'e',
      "<cmd>lua require('spider').motion('e',{ skipInsignificantPunctuation = false })<CR>",
      mode = {
        'n',
        'o',
        'x',
      },
      desc = 'Spider-e',
    },
    {
      'b',
      "<cmd>lua require('spider').motion('b')<CR>",
      mode = {
        'n',
        'o',
        'x',
      },
      desc = 'Spider-b',
    },
    {
      '<C-f>',
      "<Esc>l<cmd>lua require('spider').motion('e',{ skipInsignificantPunctuation = false })<CR>a",
      mode = { 'i' },
      desc = 'Spider-w',
    },
    {
      '<C-b>',
      "<Esc><cmd>lua require('spider').motion('b')<CR>i",
      mode = { 'i' },
      desc = 'Spider-b',
    },
  },
})

-- Portal
-- package({
--   'cbochs/portal.nvim',
--   opts = {
--     window_options = {
--       border = 'rounded',
--     },
--   },
--   keys = {
--     {
--       '<c-]>',
--       function()
--         require('portal.builtin').jumplist.tunnel_forward()
--       end,
--       desc = 'Jump Forward',
--     },
--     {
--       '<c-[',
--       function()
--         require('portal.builtin').jumplist.tunnel_backward()
--       end,
--       desc = 'Jump Backward',
--     },
--   },
-- })

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
        pre_save_cmds = {
          function()
            vim.api.nvim_exec_autocmds('User', { pattern = 'SessionSavePre' })
          end,
        },
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
    {
      'JMarkin/nvim-tree.lua-float-preview',
      lazy = true,
      -- default
      opts = {
        -- Whether the float preview is enabled by default. When set to false, it has to be "toggled" on.
        toggled_on = true,
        -- wrap nvimtree commands
        wrap_nvimtree_commands = false,
        -- lines for scroll
        scroll_lines = 20,
        mapping = {
          -- scroll down float buffer
          down = { '<C-f>' },
          -- scroll up float buffer
          up = { '<C-b>' },
          -- enable/disable float windows
          toggle = { '<c-p>' },
        },
        -- hooks if return false preview doesn't shown
        hooks = {
          pre_open = function(path)
            -- if file > 5 MB or not text -> not preview
            local size = require('float-preview.utils').get_size(path)
            if type(size) ~= 'number' then
              return false
            end
            local is_text = require('float-preview.utils').is_text(path)
            return size < 5 and is_text
          end,
          post_open = function(bufnr)
            return true
          end,
        },
        window = {
          style = 'minimal',
          relative = 'win',
          border = 'rounded',
          wrap = false,
          trim_height = false,
          open_win_config = function(buf)
            local WIDTH_RATIO = 0.4
            local HEIGHT_RATIO = 0.8
            -- calc position of nvimtree main window
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            local window_w = screen_w * WIDTH_RATIO
            local window_h = screen_h * HEIGHT_RATIO
            local window_w_int = math.floor(window_w)
            local window_h_int = math.floor(window_h)
            local center_x = (screen_w - window_w) * 7 / 8
            local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
            -- return preview window
            return {
              border = 'rounded',
              relative = 'editor',
              row = center_y,
              -- row = 0,
              col = center_x,
              width = window_w_int,
              height = window_h_int,
              title = buf,
            }
          end,
        },
      },
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
        comment = { suffix = '/', options = {} },
        conflict = { suffix = 'd', options = {} },
        diagnostic = { suffix = 'x', options = {} },
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

-- Matching things
-- package({
--   'andymass/vim-matchup',
--   setup = function()
--     vim.g.matchup_matchparen_offscreen = { method = 'popup' }
--   end,
-- })

-- Big Files
package({
  'LunarVim/bigfile.nvim',
  config = function()
    require('bigfile').setup({
      filesize = 2, -- size of the file in MiB, the plugin round file sizes to the closest MiB
      pattern = { '*' }, -- autocmd pattern or function see <### Overriding the detection of big files>
      features = { -- features to disable
        'indent_blankline',
        'illuminate',
        'lsp',
        'treesitter',
        'syntax',
        'matchparen',
        'vimopts',
        'filetype',
      },
    })
  end,
})

-- Search / Replace
package({
  'nvim-pack/nvim-spectre',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    is_insert_mode = true,
  },
})
