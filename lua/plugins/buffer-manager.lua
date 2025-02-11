return {
  "j-morano/buffer_manager.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "s1n7ax/window-picker",
  },
  enabled = false,
  keys = {
    {
      "<tab>",
      function()
        require("buffer_manager.ui").toggle_quick_menu()
      end,
    },
    {
      "<s-tab>",
      function()
        require("buffer_manager.ui").toggle_quick_menu()
      end,
    },
  },
  opts = {
    line_keys = "1234567890",
    select_menu_item_commands = {
      edit = {
        key = "l",
        command = "edit",
      },
    },
    focus_alternate_buffer = false,
    short_file_names = false,
    short_term_names = false,
    loop_nav = true,
    highlight = "Normal:FloatBorder",
    win_extra_options = {
      winhighlight = "Normal:BufferManagerNormal",
    },
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    format_function = nil,
    order_buffers = "lastused",
    show_indicators = false,
  },
}
