local M = {}

-- vim vinegar-esque in-place explore/pick
local function toggle_replace()
  local api = require('nvim-tree.api')
  if api.tree.is_visible() then
    api.tree.close()
  else
    api.node.open.replace_tree_buffer()
  end
end

local function edit_or_open()
  local api = require('nvim-tree.api')
  local node = api.tree.get_node_under_cursor()
  if node.nodes ~= nil then
    -- expand or collapse folder
    api.node.open.edit()
  else
    -- open file
    api.node.open.edit()
    -- Close the tree if file was opened
    api.tree.close()
  end
end

-- open as vsplit on current node
local function vsplit_preview()
  local api = require('nvim-tree.api')
  local node = api.tree.get_node_under_cursor()
  if node.nodes ~= nil then
    -- expand or collapse folder
    api.node.open.edit()
  else
    -- open file as vsplit
    api.node.open.vertical()
  end
  -- Finally refocus on tree if it was lost
  api.tree.focus()
end

-- mappings etc...
local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  -- floatpreview
  local floatpreview = require('float-preview')
  local float_close_wrap = floatpreview.close_wrap
  local Event = api.events.Event

  floatpreview.attach_nvimtree(bufnr)

  api.events.subscribe(Event.TreeClose, function()
    vim.schedule(function()
      float_close_wrap(function() end)()
    end)
  end)

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  api.config.mappings.default_on_attach(bufnr)

  -- this allows float preview to not throw errors on exit
  vim.keymap.set('n', '-', float_close_wrap(api.tree.close), opts('Close'))
  vim.keymap.set('n', 'q', float_close_wrap(api.tree.close), opts('Close'))

  -- halp
  vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))

  -- hjkl
  vim.keymap.set('n', 'l', edit_or_open, opts('Edit/Open'))
  vim.keymap.set('n', 'h', api.tree.close, opts('Close'))
  vim.keymap.set('n', 'H', api.tree.collapse_all, opts('Collapse All'))
end

-- plugin setup
function M.setup()
  vim.opt.termguicolors = true

  local WIDTH_RATIO = 0.4
  local HEIGHT_RATIO = 0.8

  local nonicons_extension = require('nvim-nonicons.extentions.nvim-tree')

  require('nvim-tree').setup({
    on_attach = on_attach,
    filters = {
      dotfiles = false,
      exclude = { vim.fn.stdpath('config') .. '/lua/custom' },
      custom = { '^.git$' },
    },
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = true,
    sync_root_with_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = false,
    },
    view = {
      float = {
        enable = true,
        open_win_config = function()
          local screen_w = vim.opt.columns:get()
          local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
          local window_w = screen_w * WIDTH_RATIO
          local window_h = screen_h * HEIGHT_RATIO
          local window_w_int = math.floor(window_w)
          local window_h_int = math.floor(window_h)
          local center_x = (screen_w - window_w) / 8
          local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
          return {
            border = 'rounded',
            relative = 'editor',
            row = center_y,
            -- row = 0,
            col = center_x,
            width = window_w_int,
            height = window_h_int,
          }
        end,
      },
    },
    modified = {
      enable = true,
    },
    git = {
      enable = true,
      ignore = true,
    },
    filesystem_watchers = {
      enable = true,
    },
    actions = {
      open_file = {
        quit_on_open = true,
        resize_window = false,
        window_picker = {
          enable = true,
          picker = 'default',
          chars = 'ASDFGHJKL',
          exclude = {
            filetype = { 'notify', 'lazy', 'qf', 'diff', 'fugitive', 'fugitiveblame', 'trouble' },
            buftype = { 'nofile', 'terminal', 'help' },
          },
        },
      },
      remove_file = {
        close_window = true,
      },
    },
    renderer = {
      root_folder_label = ':t',
      highlight_git = true,
      highlight_modified = 'name',
      indent_markers = {
        enable = true,
      },
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = false,
          modified = true,
        },
        glyphs = nonicons_extension.glyphs,
      },
    },
  })
end

return M
