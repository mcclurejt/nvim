---@diagnostic disable: missing-fields
return {
  "rebelot/heirline.nvim",
  enabled = false,
  lazy = false,
  dependencies = {
    {
      "Zeioth/heirline-components.nvim",
      opts = {
        icons = { TabClose = "" },
      },
    },
    "tiagovla/scope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    {
      "<c-s-,>",
      function()
        require("heirline-components.buffer").move(-1)
      end,
      desc = "Buffer Move Left",
    },
    {
      "<c-s-.>",
      function()
        require("heirline-components.buffer").move(1)
      end,
      desc = "Buffer Move Right",
    },
    {
      "<leader>bl",
      function()
        require("heirline-components.buffer").close_left()
      end,
      desc = "Buffer Close Left of Current",
    },
    {
      "<leader>br",
      function()
        require("heirline-components.buffer").close_right()
      end,
      desc = "Buffer Close Right of Current",
    },
    {
      "<tab>",
      function()
        require("heirline-components.buffer").nav(1)
      end,
      desc = "Buffer Navigate Right",
    },
    {
      "<s-l>",
      function()
        require("heirline-components.buffer").nav(1)
      end,
      desc = "Buffer Navigate Right",
    },
    {
      "<s-tab>",
      function()
        require("heirline-components.buffer").nav(-1)
      end,
      desc = "Buffer Navigate Left",
    },
    {
      "<s-h>",
      function()
        require("heirline-components.buffer").nav(-1)
      end,
      desc = "Buffer Navigate Left",
    },
    -- {
    --   "gbd",
    --   LazyVim.ui.bufremove,
    --   desc = "Buffer Delete",
    -- },
  },
  config = function()
    local heirline = require("heirline")
    local heirline_components = require("heirline-components.all")
    local lib = heirline_components
    local devicons = require("nvim-web-devicons")
    local colors = require("catppuccin.palettes").get_palette("mocha")

    heirline_components.init.subscribe_to_events()
    heirline.load_colors(heirline_components.hl.get_colors())
    heirline.setup({
      opts = {},
      tabline = { -- UI upper bar
        lib.component.tabline_conditional_padding(),
        lib.component.tabline_tabpages({
          condition = function() -- display if more than 1 tab.
            return true
          end,
          close_button = false,
        }),
        lib.component.fill({ hl = { bg = "tabline_bg" } }),
        lib.component.tabline_buffers({
          close_button = false,
          file_icon = {
            hl = function(self)
              local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.bufnr), ":t")
              ---@diagnostic disable-next-line: unused-local
              local ft_icon, ft_color = devicons.get_icon_color(filename)
              local is_mod = vim.bo[self.bufnr].modified
              local invert = require("catppuccin.utils.colors").invertColor
              local hl = {}
              if self.tab_type == "buffer_active" then
                hl = {
                  bg = is_mod and colors.peach or colors.lavender,
                  fg = colors.surface0,
                }
              elseif self.tab_type == "buffer_visible" then
                hl = {
                  bg = colors.surface0,
                  fg = is_mod and colors.peach or colors.lavender,
                }
              else
                hl = {
                  fg = is_mod and colors.peach or colors.overlay2,
                  bg = colors.surface0,
                }
              end
              return hl
            end,
          },
          file_modified = false,
          filename = {
            padding = { left = 1, right = 1 },
            hl = function(self)
              local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.bufnr), ":t")
              ---@diagnostic disable-next-line: unused-local
              local ft_icon, ft_color = devicons.get_icon_color(filename)
              local is_mod = vim.bo[self.bufnr].modified
              local invert = require("catppuccin.utils.colors").invertColor
              local hl = {}
              if self.tab_type == "buffer_active" then
                hl = {
                  bg = is_mod and colors.peach or colors.lavender,
                  fg = colors.surface0,
                  bold = true,
                }
              elseif self.tab_type == "buffer_visible" then
                hl = {
                  fg = is_mod and colors.peach or colors.lavender,
                  bg = colors.surface0,
                  bold = true,
                }
              else
                hl = {
                  fg = is_mod and colors.peach or colors.overlay2,
                  bg = colors.surface0,
                }
              end
              return hl
            end,
          },
          padding = {
            left = 0,
            right = 1,
          },
          hl = function(self)
            return {
              fg = colors.base,
              bg = colors.base,
            }
          end,
        }),
        lib.component.fill({ hl = { bg = "tabline_bg" } }),
      },
    })
  end,
  opts = {},
}
