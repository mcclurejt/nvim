local is_visible = function(bufnr)
  for _, tabid in ipairs(vim.api.nvim_list_tabpages()) do
    for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(tabid)) do
      local winbufnr = vim.api.nvim_win_get_buf(winid)
      local winvalid = vim.api.nvim_win_is_valid(winid)

      if winvalid and winbufnr == bufnr then
        return true
      end
    end
  end

  return false
end

return {
  "nvim-lualine/lualine.nvim",
  enabled = true,
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "yamatsum/nvim-nonicons",
    "folke/snacks.nvim",
  },
  opts = function(_, opts)
    local nonicons_extention = require("nvim-nonicons.extentions.lualine")
    local icons = require("lazyvim.config").icons
    local colors = require("catppuccin.palettes").get_palette("mocha")
    local color_utils = require("catppuccin.utils.colors")
    opts.options.theme = "catppuccin"
    opts.options.section_separators = ""
    opts.options.component_separators = ""
    opts.options.extensions = {
      "quickfix",
      "nvim-tree",
      "toggleterm",
      "lazy",
    }
    opts.sections = {
      lualine_a = {
        nonicons_extention.mode,
      },
      lualine_b = {
        { "branch", icon = "", draw_empty = true },
        {
          "diff",
          symbols = {
            added = icons.git.added,
            modified = icons.git.modified,
            removed = icons.git.removed,
          },
          source = function()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
              return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
              }
            end
          end,
          draw_empty = true,
        },
      },
      lualine_c = {
        "%=",
        {
          "diagnostics",
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
        },
      },
      lualine_x = {
        LazyVim.lualine.pretty_path({ relative = "cwd", filename_hl = "@repeat" }),
        -- {
        --   "windows",
        --   padding = 4,
        --   windows_color = {
        --     -- Same values as the general color option can be used here.
        --     active = "lualine_a_visual", -- Color for active window.
        --     inactive = "lualine_b_visual", -- Color for inactive window.
        --   },
        -- },

        --        "%=",
                -- stylua: ignore
                {
                  function() return require("noice").api.status.command.get() end,
    ---@diagnostic disable-next-line: undefined-field
                  cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                  color = function () return{ fg= Snacks.util.color("Statement") } end,
                },
                -- stylua: ignore
                {
    ---@diagnostic disable-next-line: undefined-field
                  function() return require("noice").api.status.mode.get() end,
    ---@diagnostic disable-next-line: undefined-field
                  cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                  color =function() return {fg= Snacks.util.color("Constant") } end,
                },
                -- stylua: ignore
                {
                  function() return "  " .. require("dap").status() end,
                  cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
                  color = function() return { fg=Snacks.util.color("Debug") } end,
                },
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = function()
            return { fg = Snacks.util.color("Special") }
          end,
        },
      },
      lualine_y = {
        { "progress", separator = " ", padding = { left = 1, right = 0 } },
        { "location", padding = { left = 0, right = 1 } },
      },
      lualine_z = {
        function()
          return " " .. os.date("%R")
        end,
      },
    }

    -- opts.tabline = {
    --   lualine_a = {
    --     { "tabs", use_mode_colors = true },
    --     {
    --       "windows",
    --       windows_color = {
    --         -- Same values as the general color option can be used here.
    --         active = "lualine_a_visual", -- Color for active window.
    --         inactive = "lualine_b_visual", -- Color for inactive window.
    --       },
    --     },
    --   },
    --   lualine_b = {
    --
    --     -- {
    --     --   "windows",
    --     --   padding = 4,
    --     --   use_mode_colors = true,
    --     -- windows_color = {
    --     --   -- Same values as the general color option can be used here.
    --     --   active = "lualine_a_visual", -- Color for active window.
    --     --   inactive = "lualine_b_visual", -- Color for inactive window.
    --     -- },
    --     -- },
    --   },
    --   lualine_c = {
    --     "%=",
    --   },
    --   lualine_x = {
    --     {
    --       "buffers",
    --       padding = 2,
    --       use_mode_colors = true,
    --       show_filename_only = true,
    --       -- icons_enabled = true,
    --       symbols = {
    --         alternate_file = "",
    --       },
    --       buffers_color = {
    --         -- Same values as the general color option can be used here.
    --         active = "lualine_a_inactive", -- Color for active buffer.
    --         inactive = "lualine_c_inactive", -- Color for inactive buffer.
    --       },
    --       -- fmt = function(name, context)
    --       --   if is_visible(context.bufnr) then
    --       --     local cwd = LazyVim.root.cwd()
    --       --     local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(context.bufnr), ":p")
    --       --     path = path:sub(#cwd + 2)
    --       --     return path
    --       --   end
    --       --   return name
    --       -- end,
    --       -- buffers_color = {
    --       --   -- Same values as the general color option can be used here.
    --       --   active = { fg = colors.mauve, bg = colors.base, gui = "bold" }, -- Color for active buffer.
    --       -- },
    --     },
    --   },
    --   lualine_y = {},
    --   lualine_z = { nonicons_extention.mode },
    -- }
    opts.winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "%=", LazyVim.lualine.pretty_path({ relative = "cwd", filename_hl = "@exception" }), "%=" },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    }
    opts.inactive_winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {
        LazyVim.lualine.pretty_path({ relative = "cwd" }),
        "%=",
      },
      lualine_y = {},
      lualine_z = {},
    }

    return opts
  end,
}
