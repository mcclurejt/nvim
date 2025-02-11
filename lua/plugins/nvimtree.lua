-- vim vinegar-esque in-place explore/pick
local function toggle_replace()
  local api = require("nvim-tree.api")
  if api.tree.is_visible() then
    api.tree.close()
  else
    api.node.open.replace_tree_buffer()
  end
end

local function edit_or_open()
  local api = require("nvim-tree.api")
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
  local api = require("nvim-tree.api")
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
  local api = require("nvim-tree.api")

  -- floatpreview
  local floatpreview = require("float-preview")
  local float_close_wrap = floatpreview.close_wrap
  local Event = api.events.Event

  floatpreview.attach_nvimtree(bufnr)

  api.events.subscribe(Event.TreeClose, function()
    vim.schedule(function()
      float_close_wrap(function() end)()
    end)
  end)

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  api.config.mappings.default_on_attach(bufnr)

  -- this allows float preview to not throw errors on exit
  vim.keymap.set("n", "-", float_close_wrap(api.tree.close), opts("Close"))
  vim.keymap.set("n", "q", float_close_wrap(api.tree.close), opts("Close"))

  -- halp
  vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))

  -- hjkl
  vim.keymap.set("n", "l", edit_or_open, opts("Edit/Open"))
  vim.keymap.set("n", "h", api.tree.close, opts("Close"))
  vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse All"))
end

-- plugin setup
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    {
      "yamatsum/nvim-nonicons",
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
      "JMarkin/nvim-tree.lua-float-preview",
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
          down = { "<C-f>" },
          -- scroll up float buffer
          up = { "<C-b>" },
          -- enable/disable float windows
          toggle = { "<c-p>" },
        },
        -- hooks if return false preview doesn't shown
        hooks = {
          pre_open = function(path)
            -- if file > 5 MB or not text -> not preview
            local size = require("float-preview.utils").get_size(path)
            if type(size) ~= "number" then
              return false
            end
            local is_text = require("float-preview.utils").is_text(path)
            return size < 5 and is_text
          end,
          ---@diagnostic disable-next-line: unused-local
          post_open = function(bufnr)
            return true
          end,
        },
        window = {
          style = "minimal",
          relative = "win",
          border = "rounded",
          wrap = false,
          trim_height = false,
          open_win_config = function(buf)
            local WIDTH_RATIO = 0.3
            local HEIGHT_RATIO = 0.8
            -- calc position of nvimtree main window
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            local window_w = screen_w * WIDTH_RATIO
            local window_h = screen_h * HEIGHT_RATIO
            local window_w_int = math.floor(window_w)
            local window_h_int = math.floor(window_h)
            local center_x = (screen_w - window_w) * 6 / 8
            local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
            -- return preview window
            return {
              border = "rounded",
              relative = "editor",
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
  keys = {
    {
      "-",
      function()
        require("nvim-tree.api").tree.toggle({ focus = true })
      end,
      desc = "NvimTree Toggle",
    },
  },
  config = function()
    vim.opt.termguicolors = true

    local WIDTH_RATIO = 0.3
    local HEIGHT_RATIO = 0.8

    local nonicons = require("nvim-nonicons")

    -- automatically resize the nvimtree when neovim's window size changes
    local tree_api = require("nvim-tree")
    local tree_view = require("nvim-tree.view")
    vim.api.nvim_create_augroup("NvimTreeResize", {
      clear = true,
    })
    vim.api.nvim_create_autocmd({ "VimResized" }, {
      group = "NvimTreeResize",
      callback = function()
        if tree_view.is_visible() then
          tree_view.close()
          tree_api.open()
        end
      end,
    })

    -- call setup
    require("nvim-tree").setup({
      on_attach = on_attach,
      filters = {
        dotfiles = false,
        exclude = { vim.fn.stdpath("config") .. "/lua/custom" },
        custom = { "^.git$" },
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
        signcolumn = "yes",
        float = {
          enable = true,
          open_win_config = function()
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            local window_w = screen_w * WIDTH_RATIO
            local window_h = screen_h * HEIGHT_RATIO
            local window_w_int = math.floor(window_w)
            local window_h_int = math.floor(window_h)
            local center_x = (screen_w - window_w) / 4
            local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
            return {
              border = "rounded",
              relative = "editor",
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
        timeout = 1000,
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
            chars = "ASDFGHJKL;",
            -- picker = require("window-picker").pick_window,
          },
        },
        remove_file = {
          close_window = true,
        },
      },
      live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = false,
      },
      renderer = {
        root_folder_label = ":t",
        highlight_git = "name",
        highlight_modified = "name",
        indent_markers = {
          enable = true,
        },
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = false,
            git = false,
            modified = false,
          },
          glyphs = {
            git = {
              unstaged = nonicons.get("diff-modified"),
              staged = "",
              unmerged = nonicons.get("git-merge-queue"),
              renamed = nonicons.get("diff-renamed"),
              untracked = nonicons.get("diff-added"),
              deleted = nonicons.get("diff-removed"),
              ignored = nonicons.get("diff-ignored"),
            },
          },
          git_placement = "signcolumn",
        },
      },
    })
  end,
}
