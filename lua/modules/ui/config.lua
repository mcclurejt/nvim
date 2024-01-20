local config = {}

-------------------------------------------------------------------------------
-- Colorscheme
-------------------------------------------------------------------------------

---@diagnostic disable-next-line: unused-local, unused-function
local function get_mode_hl(colors)
  local mode = vim.api.nvim_get_mode().mode
  local mode_to_hl = {
    n = {
      fg = colors.blue,
    },
    i = {
      fg = colors.green,
    },
    t = {
      fg = colors.lavender,
    },
    c = {
      fg = colors.peach,
    },
    v = {
      fg = colors.mauve,
    },
    R = {
      fg = colors.red,
    },
  }
  return mode_to_hl[mode]
end

-- source: https://gist.github.com/lkhphuc/ea6db0458268cad1493b2674cb0fda51
-- Due to the way different colorschemes configure different highlights group,
-- there is no universal way to add gui options to all the desired components.
-- Findout the final highlight group being linked to and update gui option.
---@diagnostic disable-next-line: unused-function, unused-local
local function mod_hl(hl_name, opts)
  -- local is_ok, hl_def = pcall(vim.api.nvim_get_hl_by_name, hl_name, true)
  ---@diagnostic disable-next-line: undefined-field
  local is_ok, hl_def = pcall(vim.api.nvim_get_hl_by_name, hl_name, true)
  if is_ok then
    for k, v in pairs(opts) do
      hl_def[k] = v
    end
    vim.api.nvim_set_hl(0, hl_name, hl_def)
  end
end

function config.catppuccin()
  require('catppuccin').setup({
    dim_inactive = {
      enabled = true,
    },
    term_colors = true,
    integrations = {
      aerial = true,
      alpha = true,
      cmp = true,
      dashboard = true,
      flash = true,
      gitsigns = true,
      headlines = true,
      illuminate = true,
      indent_blankline = { enabled = true },
      leap = true,
      lsp_trouble = true,
      mason = true,
      markdown = true,
      mini = {
        enabled = true,
      },
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = {},
          hints = {},
          warnings = {},
          information = {},
        },
        underlines = {
          errors = { 'undercurl' },
          hints = { 'undercurl' },
          warnings = { 'undercurl' },
          information = { 'undercurl' },
        },
        inlay_hints = {
          background = true,
        },
      },
      navic = { enabled = true, custom_bg = 'lualine' },
      neotest = true,
      neotree = true,
      nvimtree = true,
      noice = true,
      notify = true,
      semantic_tokens = true,
      telescope = true,
      treesitter = true,
      treesitter_context = true,
      which_key = true,
    },
    custom_highlights = function(colors)
      return {
        -- NeoTree
        -- NeoTreeTabActive = {
        --   fg = colors.blue,
        --   bg = colors.base,
        -- },
        -- NeoTreeTabInactive = {
        --   bg = colors.base,
        -- },
        -- NeoTreeNormal = {
        --   bg = colors.base,
        -- },
        -- NeoTreeNormalNC = {
        --   bg = colors.mantle,
        -- },
        -- NeoTreeFloatBorder = {
        --   fg = colors.blue,
        --   bg = colors.base,
        -- },
        -- NeoTreeFloatTitle = {
        --   fg = colors.blue,
        --   bg = colors.base,
        -- },
        -- NeoTreeTabSeparatorActive = {
        --   fg = colors.base,
        --   bg = colors.base,
        -- },
        -- NeoTreeTabSeparatorInactive = {
        --   fg = colors.base,
        --   bg = colors.base,
        -- },

        -- Enhance float titles
        FloatTitle = {
          fg = colors.text,
        },

        -- Noice Cmdline
        NoiceCmdlinePopupTitle = {
          fg = colors.text,
        },
        NoiceCmdlineIcon = {
          fg = colors.peach,
        },
        NoiceCmdlinePopupBorder = {
          fg = colors.peach,
        },

        -- Noice Search
        NoiceCmdlineIconSearch = {
          fg = colors.mauve,
        },
        NoiceCmdlinePopupBorderSearch = {
          fg = colors.mauve,
        },
      }
    end,
  })
  vim.cmd.colorscheme('catppuccin-mocha')
  vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    callback = function()
      package.loaded['feline'] = nil
      package.loaded['catppuccin.groups.integrations.feline'] = nil
      require('feline').setup({
        components = require('catppuccin.groups.integrations.feline').get(),
      })
    end,
  })
end

-------------------------------------------------------------------------------
-- Indent Guides
-------------------------------------------------------------------------------

function config.indent_blankline()
  local p = require('catppuccin.palettes').get_palette('mocha')
  local hooks = require('ibl.hooks')
  local highlight = {
    'RainbowRed',
    'RainbowYellow',
    'RainbowBlue',
    'RainbowOrange',
    'RainbowGreen',
    'RainbowViolet',
    'RainbowCyan',
  }
  -- create the highlight groups in the highlight setup hook, so they are reset
  -- every time the colorscheme changes
  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, 'RainbowRed', { fg = p.red })
    vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = p.yellow })
    vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = p.blue })
    vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = p.peach })
    vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = p.green })
    vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = p.lavender })
    vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = p.sky })
  end)

  vim.g.rainbow_delimiters = { highlight = highlight }
  require('ibl').setup({
    -- indent = { char = '┊' },
    -- scope = { highlight = highlight },
    scope = { enabled = false },
    indent = { char = '┊', highlight = highlight },
    exclude = {
      filetypes = {
        'help',
        'alpha',
        'dashboard',
        'neo-tree',
        'Trouble',
        'trouble',
        'lazy',
        'mason',
        'notify',
        'toggleterm',
        'lazyterm',
        'NvimTree',
      },
    },
  })
  -- links highlights with rainbow-delimiters
  hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
end

-------------------------------------------------------------------------------
-- NeoTree
-------------------------------------------------------------------------------

function config.neo_tree()
  ---@diagnostic disable-next-line: unused-local
  local highlights = require('neo-tree.ui.highlights')
  require('neo-tree').setup({
    popup_border_style = 'rounded',
    auto_clean_after_session_restore = true,
    open_files_do_not_replace_types = { 'terminal', 'Trouble', 'trouble', 'qf', 'Outline', 'sagaoutline' },
    default_component_configs = {
      file_size = {
        enabled = false,
      },
      type = {
        enabled = false,
      },
      last_modified = {
        enabled = false,
      },
      indent = {
        with_markers = false,
      },
      git_status = {
        symbols = {
          -- Change type
          added = '', -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified = '', -- or "", but this is redundant info if you use git_status_colors on the name
          deleted = '', -- this can only be used in the git_status source
          renamed = '', -- this can only be used in the git_status source
          -- Status type
          untracked = '󰛲',
          ignored = '󰳤',
          unstaged = '󰿦',
          staged = '󰋓',
          conflict = '󰅘',
        },
      },
    },
    sources = {
      'filesystem',
      -- 'document_symbols',
      'buffers',
      -- 'diagnostics',
      'git_status',
    },
    source_selector = {
      winbar = true,
      content_layout = 'center',
      sources = {
        { source = 'filesystem' },
        -- { source = 'document_symbols' },
        -- { source = 'buffers' },
        -- { source = 'diagnostics', display_name = ' Diagnostics' },
        { source = 'git_status' },
      },
    },
    commands = {
      view_file_explorer = function()
        vim.api.nvim_exec('Neotree reveal filesystem', true)
      end,
      view_buffer_explorer = function()
        vim.api.nvim_exec('Neotree reveal buffers', true)
      end,
      view_git_explorer = function()
        vim.api.nvim_exec('Neotree reveal git_status', true)
      end,
      view_symbol_explorer = function()
        vim.api.nvim_exec('Neotree reveal document_symbols', true)
      end,
      view_diagnostics = function()
        vim.api.nvim_exec('Neotree reveal diagnostics', true)
      end,
    },
    window = {
      position = 'left',
      mappings = {
        ['<space>'] = 'none',
        ['v'] = 'none',
        ['P'] = { 'toggle_preview', config = { use_float = true, use_image_nvim = true } },
        ['i'] = 'focus_preview',
        ['<c-v>'] = 'open_vsplit',
        ['<c-x>'] = 'open_split',
      },
      fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
        ['<C-j>'] = 'move_cursor_down',
        ['<C-k>'] = 'move_cursor_up',
      },
      popup = {
        position = { col = '50%', row = '2' },
        size = function(state)
          local root_name = vim.fn.fnamemodify(state.path, ':~')
          local root_len = string.len(root_name) + 16
          return {
            width = math.max(root_len, 100),
            height = vim.o.lines - 24,
          }
        end,
      },
    },
    filesystem = {
      bind_to_cwd = true,
      cwd_target = {
        sidebar = 'tab', -- sidebar is when position = left or right
        current = 'tab', -- current is when position = current
      },
      follow_current_file = { enabled = true },
      commands = {
        back = function(state)
          local node = state.tree:get_node()
          if node.type == 'directory' and node:is_expanded() then
            require('neo-tree.sources.filesystem').toggle_directory(state, node)
          else
            require('neo-tree.ui.renderer').focus_node(state, node:get_parent_id())
          end
        end,
        enter = function(state)
          local node = state.tree:get_node()
          if node.type == 'directory' then
            if not node:is_expanded() then
              require('neo-tree.sources.filesystem').toggle_directory(state, node)
            elseif node:has_children() then
              require('neo-tree.ui.renderer').focus_node(state, node:get_child_ids()[1])
            end
          end
        end,
        trash = function(state)
          local utils = require('neo-tree.utils')
          local inputs = require('neo-tree.ui.inputs')
          local tree = state.tree
          local node = tree:get_node()
          if node.type == 'message' then
            return
          end
          local _, name = utils.split_path(node.path)
          local msg = string.format("Are you sure you want to trash '%s'?", name)
          inputs.confirm(msg, function(confirmed)
            if not confirmed then
              return
            end
            vim.api.nvim_command('silent !trash -F ' .. node.path)
            require('neo-tree.sources.filesystem.commands').refresh(state)
          end)
        end,
        run_command = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          vim.api.nvim_input(': ' .. path .. '<Home>')
        end,
      },
      window = {
        mappings = {
          ['h'] = 'back',
          ['l'] = 'enter',
          ['t'] = 'trash',
          ['<c-v>'] = 'open_vsplit',
          ['<c-x>'] = 'open_split',
          ['<Tab>'] = 'next_source',
          ['<S-Tab>'] = 'prev_source',
        },
      },
    },
    git_status = {
      window = {
        mappings = {
          ['<Tab>'] = 'next_source',
          ['<S-Tab>'] = 'prev_source',
        },
      },
    },
    buffers = {
      show_unloaded = true,
      window = {
        position = 'float',
        mappings = {
          ['d'] = 'buffer_delete',
          ['<Tab>'] = 'close_window',
        },
      },
    },
    event_handlers = {
      -- hide cursor
      {
        event = 'neo_tree_buffer_enter',
        handler = function()
          -- This effectively hides the cursor
          vim.cmd('highlight! Cursor blend=100')
        end,
      },
      {
        event = 'neo_tree_buffer_leave',
        handler = function()
          -- Make this whatever your current Cursor highlight group is.
          vim.cmd('highlight! Cursor guibg=#5f87af blend=0')
        end,
      },
      -- resize windows on enter/leave
      {
        event = 'neo_tree_window_after_open',
        handler = function(args)
          if args.position == 'left' or args.position == 'right' then
            vim.cmd('wincmd =')
          end
        end,
      },
      {
        event = 'neo_tree_window_after_close',
        handler = function(args)
          if args.position == 'left' or args.position == 'right' then
            vim.cmd('wincmd =')
          end
        end,
      },
    },
  })
end

return config
