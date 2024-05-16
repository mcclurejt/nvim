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

-- package({
--   'echasnovski/mini.indentscope',
--   version = false,
--   config = function()
--     require('mini.indentscope').setup({})
--   end,
-- })

-- Gitsigns
package({
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup({
      -- signs = {
      --   add = { text = '▎' },
      --   change = { text = '▎' },
      --   delete = { text = '▎' },
      --   topdelete = { text = '▎' },
      --   changedelete = { text = '▎' },
      -- },
      trouble = true,
      current_line_blame = true,
      numhl = false,
      signcolumn = true,
      diff_opts = {
        internal = true,
        linematch = true,
      },
      -- word_diff = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal({ ']c', bang = true })
          else
            gitsigns.nav_hunk('next')
          end
        end)

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal({ '[c', bang = true })
          else
            gitsigns.nav_hunk('prev')
          end
        end)

        -- Actions
        -- map('n', '<leader>hs', gitsigns.stage_hunk)
        -- map('n', '<leader>hr', gitsigns.reset_hunk)
        -- map('v', '<leader>hs', function()
        --   gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        -- end)
        -- map('v', '<leader>hr', function()
        --   gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        -- end)
        -- map('n', '<leader>hS', gitsigns.stage_buffer)
        -- map('n', '<leader>hu', gitsigns.undo_stage_hunk)
        -- map('n', '<leader>hR', gitsigns.reset_buffer)
        map('n', '<leader>gp', gitsigns.preview_hunk)
        -- map('n', 'gb', function()
        --   gitsigns.blame_line({ full = true })
        -- end)
        -- map('n', 'gb', gitsigns.toggle_current_line_blame)
        -- map('n', '<leader>gd', gitsigns.diffthis)
        -- map('n', '<leader>hD', function()
        --   gitsigns.diffthis('~')
        -- end)
        -- map('n', '<leader>gd', gitsigns.toggle_deleted)

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end,
    })
  end,
})

-- NeoTree
-- package({
--   'nvim-neo-tree/neo-tree.nvim',
--   dependencies = {
--     'nvim-lua/plenary.nvim',
--     'nvim-tree/nvim-web-devicons',          -- not strictly required, but recommended
--     'MunifTanjim/nui.nvim',
--     '3rd/image.nvim',                       -- Optional image support in preview window: See `# Preview Mode` for more information
--     'mrbjarksen/neo-tree-diagnostics.nvim', -- diagnostics view support
--     {
--       's1n7ax/nvim-window-picker',
--       version = '2.*',
--       config = function()
--         require('window-picker').setup({
--           filter_rules = {
--             include_current_win = true,
--             autoselect_one = false,
--             selection_chars = 'ASDFGHJKL',
--             -- filter using buffer options
--             bo = {
--               filetype = { 'notify', 'lazy', 'qf', 'diff', 'fugitive', 'fugitiveblame', 'trouble' },
--               buftype = { 'nofile', 'terminal', 'help' },
--             },
--           },
--         })
--       end,
--     },
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
-- package({
--   'freddiehaddad/feline.nvim',
--   dependencies = {
--     'lewis6991/gitsigns.nvim',
--     'kyazdani42/nvim-web-devicons',
--     'yamatsum/nvim-nonicons',
--   },
--   config = function()
--     local clrs = require('catppuccin.palettes').get_palette()
--     local ctp_feline = require('catppuccin.groups.integrations.feline')
--     local U = require('catppuccin.utils.colors')
--     local icons = require('nvim-nonicons')
--     ctp_feline.setup({
--       assets = {
--         left_separator = '',
--         right_separator = '',
--         mode_icon = '',
--         dir = '󰉖',
--         file = '󰈙',
--         lsp = {
--           server = '󰅡',
--           error = icons.get('stop'),
--           warning = icons.get('alert'),
--           info = icons.get('info'),
--           hint = icons.get('light-bulb'),
--         },
--         git = {
--           branch = '',
--           added = icons.get('plus-circle'),
--           changed = icons.get('arrow-both'),
--           removed = icons.get('x-circle'),
--         },
--       },
--       sett = {
--         show_modified = true, -- show if the file has been modified
--       },
--       mode_colors = {
--         ['n'] = { 'NORMAL', clrs.lavender },
--         ['no'] = { 'N-PENDING', clrs.lavender },
--         ['i'] = { 'INSERT', clrs.green },
--         ['ic'] = { 'INSERT', clrs.green },
--         ['t'] = { 'TERMINAL', clrs.green },
--         ['v'] = { 'VISUAL', clrs.flamingo },
--         ['V'] = { 'V-LINE', clrs.flamingo },
--         ['�'] = { 'V-BLOCK', clrs.flamingo },
--         ['R'] = { 'REPLACE', clrs.maroon },
--         ['Rv'] = { 'V-REPLACE', clrs.maroon },
--         ['s'] = { 'SELECT', clrs.maroon },
--         ['S'] = { 'S-LINE', clrs.maroon },
--         ['�'] = { 'S-BLOCK', clrs.maroon },
--         ['c'] = { 'COMMAND', clrs.peach },
--         ['cv'] = { 'COMMAND', clrs.peach },
--         ['ce'] = { 'COMMAND', clrs.peach },
--         ['r'] = { 'PROMPT', clrs.teal },
--         ['rm'] = { 'MORE', clrs.teal },
--         ['r?'] = { 'CONFIRM', clrs.mauve },
--         ['!'] = { 'SHELL', clrs.green },
--       },
--       view = {
--         lsp = {
--           progress = true, -- if true the status bar will display an lsp progress indicator
--           name = false, -- if true the status bar will display the lsp servers name, otherwise it will display the text "Lsp"
--           exclude_lsp_names = {}, -- lsp server names that should not be displayed when name is set to true
--           separator = '|', -- the separator used when there are multiple lsp servers
--         },
--       },
--     })

--     require('feline').setup({
--       components = ctp_feline.get(),
--     })
--     require('feline').winbar.setup({})
--     -- require('feline').statuscolumn.setup()
--     require('feline').use_theme({})
--   end,
-- })

-- Buffers
package({
  'tiagovla/scope.nvim',
  setup = function()
    require('scope').setup({
      pre_tab_leave = function()
        vim.api.nvim_exec_autocmds('User', { pattern = 'ScopeTabLeavePre' })
      end,
      post_tab_enter = function()
        vim.api.nvim_exec_autocmds('User', { pattern = 'ScopeTabEnterPost' })
      end,
    })
  end,
})
package({
  'axkirillov/hbac.nvim',
  event = 'VeryLazy',
  opts = {
    autoclose = true,
    threshold = 10,
  },
})

-- Tabline
-- package({
--   'romgrk/barbar.nvim',
--   dependencies = {
--     'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
--     'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
--   },
--   init = function()
--     vim.g.barbar_auto_setup = true
--   end,
--   opts = {
--     insert_at_end = true,
--   },
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
  version = '*',
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
        long_message_to_split = false, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
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
-- package({
--   'j-hui/fidget.nvim',
--   config = function()
--     require('fidget').setup({
--       integration = {
--         ['nvim-tree'] = {
--           enable = true, -- Integrate with nvim-tree/nvim-tree.lua (if installed)
--         },
--       },
--     })
--   end,
-- })

-- Mini.files
-- package({
--   'echasnovski/mini.files',
--   version = false,
--   config = function()
--     require('mini.files').setup({
--       options = {
--         use_as_default_explorer = false,
--       },
--     })
--   end,
-- })

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
-- package({
--   'echasnovski/mini.clue',
--   version = false,
--   config = function()
--     local miniclue = require('mini.clue')
--     miniclue.setup({
--       {
--         triggers = {
--           -- Leader triggers
--           { mode = 'n', keys = '<Leader>' },
--           { mode = 'x', keys = '<Leader>' },
--
--           -- Built-in completion
--           { mode = 'i', keys = '<C-x>' },
--
--           -- `g` key
--           { mode = 'n', keys = 'g' },
--           { mode = 'x', keys = 'g' },
--
--           -- Marks
--           { mode = 'n', keys = "'" },
--           { mode = 'n', keys = '`' },
--           { mode = 'x', keys = "'" },
--           { mode = 'x', keys = '`' },
--
--           -- Registers
--           { mode = 'n', keys = '"' },
--           { mode = 'x', keys = '"' },
--           { mode = 'i', keys = '<C-r>' },
--           { mode = 'c', keys = '<C-r>' },
--
--           -- Window commands
--           { mode = 'n', keys = '<C-w>' },
--
--           -- `z` key
--           { mode = 'n', keys = 'z' },
--           { mode = 'x', keys = 'z' },
--         },
--
--         clues = {
--           -- Enhance this by adding descriptions for <Leader> mapping groups
--           miniclue.gen_clues.builtin_completion(),
--           miniclue.gen_clues.g(),
--           miniclue.gen_clues.marks(),
--           miniclue.gen_clues.registers(),
--           miniclue.gen_clues.windows(),
--           miniclue.gen_clues.z(),
--         },
--       },
--     })
--   end,
-- })

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
    -- local builtin = require('statuscol.builtin')
    require('statuscol').setup({
      -- configuration goes here, for example:
      -- setopt = true,
      -- relculright = true,
      -- segments = {
      --   { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
      --   {
      --     sign = { name = { 'Diagnostic' }, maxwidth = 2, auto = true },
      --     click = 'v:lua.ScSa',
      --   },
      --   { text = { builtin.lnumfunc }, click = 'v:lua.ScLa' },
      --   {
      --     sign = { name = { '.*' }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
      --     click = 'v:lua.ScSa',
      --   },
      -- },
    })
  end,
})

-- Folds
package({
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'kevinhwang91/promise-async',
  },
  config = function()
    require('ufo').setup({
      -- provider_selector = function(bufnr, filetype, buftype)
      --   return { 'treesitter', 'indent' }
      -- end,
      -- close_fold_kinds_for_ft = {
      --   default = { 'imports', 'comment' },
      -- },
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local hlgroup = 'NonText'
        local newVirtText = {}
        local suffix = '   ' .. tostring(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, hlgroup })
        return newVirtText
      end,
    })
  end,
})

package({
  'chrisgrieser/nvim-origami',
  event = 'BufReadPost', -- later will not save folds
  opts = true,
})
-- package({
--   'jghauser/fold-cycle.nvim',
--   config = function()
--     require('fold-cycle').setup()
--   end,
-- })

-- Outline
package({
  'hedyhli/outline.nvim',
  config = function()
    require('outline').setup({
      symbol_folding = {
        autofold_depth = 2,
        auto_unfold = {
          hovered = true,
        },
      },
      outline_window = {
        auto_jump = true,
        auto_close = true,
      },
      outline_items = {
        show_symbol_lineno = true,
      },
    })
  end,
})

-- Reactive Cursor
package({
  'rasulomaroff/reactive.nvim',
  dependencies = {
    'catppuccin/nvim',
  },
  config = function()
    require('reactive').setup({
      load = 'catppuccin-mocha-cursor',
    })
  end,
})

-- Windline
-- package({
--   'windwp/windline.nvim',
--   config = function()
--     require('modules.ui.config.windline')
--   end,
-- })

-- package({
--   'karb94/neoscroll.nvim',
--   config = function()
--     require('neoscroll').setup({})
--   end,
-- })

-- package({
--   'declancm/cinnamon.nvim',
--   config = function()
--     require('cinnamon').setup()
--   end,
-- })

package({
  'b0o/incline.nvim',
  dependencies = {
    'kyazdani42/nvim-web-devicons',
    'catppuccin/nvim',
  },
  event = 'VeryLazy',
  config = function()
    require('modules.ui.incline')
  end,
})

-- Code Minimap
package({
  'echasnovski/mini.map',
  dependencies = {
    'lewis6991/gitsigns.nvim',
  },
  version = false,
  config = function()
    local map = require('mini.map')
    vim.g.minimap_enable = 1
    map.setup({
      integrations = {
        map.gen_integration.builtin_search(),
        map.gen_integration.gitsigns(),
        map.gen_integration.diagnostic(),
      },
    })
  end,
})

package({
  'nvim-treesitter/nvim-treesitter-context',
  opts = { mode = 'cursor', max_lines = 3 },
})

-- package({
--   'kevinhwang91/nvim-hlslens',
--   config = function()
--     -- require('hlslens').setup() is not required
--     require('scrollbar.handlers.search').setup({
--       -- hlslens config overrides
--     })
--   end,
-- })
-- package({
--   'petertriho/nvim-scrollbar',
--   config = function()
--     require('scrollbar').setup({})
--   end,
-- })

package({
  'grapp-dev/nui-components.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
})
