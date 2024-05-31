return {
  "nvim-lualine/lualine.nvim",
  enabled = false,
  dependencies = {
    "yamatsum/nvim-nonicons",
  },
  opts = function(_, opts)
    local nonicons_extention = require("nvim-nonicons.extentions.lualine")
    local icons = require("lazyvim.config").icons
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
      lualine_a = { nonicons_extention.mode, { "branch", icon = "" } },
      lualine_b = {
        {
          "diff",
          symbols = {
            added = icons.git.added,
            modified = icons.git.modified,
            removed = icons.git.removed,
          },
          source = function()
            local diff = vim.b.minidiff_summary
            if diff then
              return {
                added = diff.add,
                modified = diff.change,
                removed = diff.delete,
              }
            end
          end,
        },
        LazyVim.lualine.root_dir(),
      },
      lualine_c = {
        {
          "diagnostics",
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
        },
        "%=",
        { "filetype", icon_only = true, separator = "", padding = { left = 2, right = 0 } },
        LazyVim.lualine.pretty_path(),
      },
      lualine_x = {
            -- stylua: ignore
            {
---@diagnostic disable-next-line: undefined-field
              function() return require("noice").api.status.command.get() end,
---@diagnostic disable-next-line: undefined-field
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = LazyVim.ui.fg("Statement"),
            },
            -- stylua: ignore
            {
---@diagnostic disable-next-line: undefined-field
              function() return require("noice").api.status.mode.get() end,
---@diagnostic disable-next-line: undefined-field
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = LazyVim.ui.fg("Constant"),
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = LazyVim.ui.fg("Debug"),
            },
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = LazyVim.ui.fg("Special"),
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
    opts.tabline = {
      lualine_a = {
        { "tabs", use_mode_colors = true },
        { "windows", use_mode_colors = true },
      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = { { "buffers", use_mode_colors = true } },
      lualine_z = {},
    }
    -- opts.winbar = {
    --   lualine_a = { LazyVim.lualine.pretty_path() },
    --   lualine_b = {},
    --   lualine_c = {},
    --   lualine_x = {},
    --   lualine_y = {},
    --   lualine_z = {},
    -- }
    return opts
  end,
}
