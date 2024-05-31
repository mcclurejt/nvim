return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "s1n7ax/nvim-window-picker",
  },
  keys = {
    { "<leader><space>", "<cmd>Telescope live_grep<cr>" },
    { "<leader>,", "<cmd>Telescope buffers initial_mode=normal<cr>" },
    { "<leader>fb", "<cmd>Telescope buffers initial_mode=normal<cr>" },
    { "gbb", "<cmd>Telescope buffers initial_mode=normal<cr>" },
  },
  opts = {
    defaults = {
      mappings = {
        n = {
          ["q"] = require("telescope.actions").close,
          ["<C-j>"] = require("telescope.actions").move_selection_next,
          ["<C-k>"] = require("telescope.actions").move_selection_previous,
          ["<cr>"] = function(prompt_bufnr)
            -- Use nvim-window-picker to choose the window by dynamically attaching a function
            local action_set = require("telescope.actions.set")
            local action_state = require("telescope.actions.state")

            local picker = action_state.get_current_picker(prompt_bufnr)
            picker.get_selection_window = function(picker, entry)
              local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
              -- Unbind after using so next instance of the picker acts normally
              picker.get_selection_window = nil
              return picked_window_id
            end

            return action_set.edit(prompt_bufnr, "edit")
          end,
          ["l"] = function(prompt_bufnr)
            -- Use nvim-window-picker to choose the window by dynamically attaching a function
            local action_set = require("telescope.actions.set")
            local action_state = require("telescope.actions.state")

            local picker = action_state.get_current_picker(prompt_bufnr)
            picker.get_selection_window = function(picker, entry)
              local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
              -- Unbind after using so next instance of the picker acts normally
              picker.get_selection_window = nil
              return picked_window_id
            end

            return action_set.edit(prompt_bufnr, "edit")
          end,
        },
        i = {
          ["<C-j>"] = require("telescope.actions").move_selection_next,
          ["<C-k>"] = require("telescope.actions").move_selection_previous,
          ["<cr>"] = function(prompt_bufnr)
            -- Use nvim-window-picker to choose the window by dynamically attaching a function
            local action_set = require("telescope.actions.set")
            local action_state = require("telescope.actions.state")

            local picker = action_state.get_current_picker(prompt_bufnr)
            picker.get_selection_window = function(picker, entry)
              local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
              -- Unbind after using so next instance of the picker acts normally
              picker.get_selection_window = nil
              return picked_window_id
            end

            return action_set.edit(prompt_bufnr, "edit")
          end,
        },
      },
      -- layout_strategy = "horizontal",
      layout_config = { prompt_position = "top" },
      sorting_strategy = "ascending",
      winblend = 0,
    },
    pickers = {
      buffers = {
        theme = "dropdown",
        initial_mode = "normal",
      },
    },
  },
}
