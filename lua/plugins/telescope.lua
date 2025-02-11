return {
  {
    "nvim-telescope/telescope.nvim",
    enabled = false,
    dependencies = {
      "s1n7ax/nvim-window-picker",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      {
        "danielfalk/smart-open.nvim",
        -- branch = "0.2.x",
        config = function()
          require("telescope").load_extension("smart_open")
        end,
        dependencies = {
          "kkharji/sqlite.lua",
          -- Only required if using match_algorithm fzf
          { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
          { "nvim-telescope/telescope-fzy-native.nvim" },
        },
      },
    },
    keys = {
      {
        "<leader><space>",
        function()
          local builtin = require("telescope.builtin")
          local themes = require("telescope.themes")
          builtin.live_grep(themes.get_dropdown({
            layout_config = {
              width = 160,
              height = 20,
            },
          }))
        end,
      },
      { "<leader>,", "<cmd>Telescope buffers theme=dropdown initial_mode=normal<cr>" },
      { "<leader>fb", "<cmd>Telescope buffers theme=dropdown initial_mode=normal<cr>" },
      {
        "gbb",
        function()
          local builtin = require("telescope.builtin")
          local themes = require("telescope.themes")
          builtin.buffers(themes.get_cursor({
            layout_config = {
              width = 50,
              height = 12,
            },
            initial_mode = "normal",
            previewer = false,
          }))
        end,
      },
      {
        "<leader>ff",
        function()
          local builtin = require("telescope.builtin")
          local themes = require("telescope.themes")
          builtin.find_files(themes.get_dropdown({
            layout_config = {
              width = 160,
              height = 20,
            },
          }))
        end,
      },
    },
    config = function()
      require("telescope").setup({
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
          -- sorting_strategy = "ascending",
          -- winblend = 0,
          -- border = false,
          pickers = {
            buffers = {
              theme = "dropdown",
              initial_mode = "normal",
            },
          },
        },
        extensions = {
          smart_open = {
            match_algorithm = "fzf",
            disable_devicons = false,
          },
        },
      })
      require("telescope").load_extension("fzf")
    end,
  },
}
