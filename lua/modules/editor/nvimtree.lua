local M = {}

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

-- vim vinegar-esque in-place explore/pick
local function toggle_replace()
  local api = require('nvim-tree.api')
  if api.tree.is_visible() then
    api.tree.close()
  else
    api.node.open.replace_tree_buffer()
  end
end

-- mappings etc...
local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.del('n', '-', { buffer = bufnr })

  -- halp
  vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))

  -- hjkl
  vim.keymap.set('n', 'l', edit_or_open, opts('Edit/Open'))
  vim.keymap.set('n', 'h', api.tree.close, opts('Close'))
  vim.keymap.set('n', 'H', api.tree.collapse_all, opts('Collapse All'))
end

-- plugin setup
function M.setup()
  local WIDTH_RATIO = 0.5
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
    hijack_unnamed_buffer_when_opening = false,
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
          local center_x = (screen_w - window_w) / 2
          local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
          return {
            border = 'rounded',
            relative = 'editor',
            row = center_y,
            col = center_x,
            width = window_w_int,
            height = window_h_int,
          }
        end,
      },
      width = function()
        return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
      end,
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
        resize_window = true,
      },
    },
    renderer = {
      root_folder_label = true,
      highlight_git = true,
      highlight_opened_files = 'none',

      indent_markers = {
        enable = true,
      },

      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = false,
        },

        glyphs = nonicons_extension.glyphs,
      },
    },
  })
end

return M
