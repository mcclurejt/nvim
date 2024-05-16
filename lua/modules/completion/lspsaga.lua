return function()
  require('lspsaga').setup({
    ui = {
      border = 'rounded',
      devicon = true,
      foldericon = true,
      title = true,
      expand = '⊞',
      collapse = '⊟',
      code_action = '💡',
      actionfix = ' ',
      lines = { '┗', '┣', '┃', '━', '┏' },
      kind = require('catppuccin.groups.integrations.lsp_saga').custom_kind(),
      -- kind = nil,
      imp_sign = '󰳛 ',
    },
    hover = {
      max_width = 0.9,
      max_height = 0.8,
      open_link = '<CR>',
      open_cmd = '!arc',
    },
    diagnostic = {
      show_code_action = true,
      show_layout = 'float',
      show_normal_height = 10,
      jump_num_shortcut = true,
      max_width = 0.8,
      max_height = 0.6,
      max_show_width = 0.9,
      max_show_height = 0.6,
      text_hl_follow = true,
      border_follow = true,
      wrap_long_lines = true,
      extend_relatedInformation = true,
      diagnostic_only_current = false,
      keys = {
        exec_action = 'o',
        quit = 'q',
        toggle_or_jump = '<CR>',
        quit_in_show = { 'q', '<ESC>' },
      },
    },
    code_action = {
      num_shortcut = true,
      show_server_name = false,
      extend_gitsigns = true,
      only_in_cursor = true,
      max_height = 0.3,
      keys = {
        quit = 'q',
        exec = '<CR>',
      },
    },
    lightbulb = {
      enable = false,
      sign = true,
      debounce = 10,
      sign_priority = 40,
      virtual_text = true,
      enable_in_insert = true,
    },
    scroll_preview = {
      scroll_down = '<C-d>',
      scroll_up = '<C-u>',
    },
    request_timeout = 2000,
    finder = {
      max_height = 0.5,
      left_width = 0.4,
      methods = {},
      default = 'ref+imp',
      layout = 'float',
      silent = false,
      filter = {},
      fname_sub = nil,
      sp_inexist = false,
      sp_global = false,
      ly_botright = false,
      keys = {
        shuttle = '[w',
        toggle_or_open = 'o',
        vsplit = 's',
        split = 'i',
        tabe = 't',
        tabnew = 'r',
        quit = 'q',
        close = '<C-c>k',
      },
    },
    definition = {
      width = 0.6,
      height = 0.5,
      save_pos = false,
      keys = {
        edit = '<C-c>o',
        vsplit = '<C-c>v',
        split = '<C-c>i',
        tabe = '<C-c>t',
        tabnew = '<C-c>n',
        quit = 'q',
        close = '<C-c>k',
      },
    },
    rename = {
      in_select = true,
      auto_save = true,
      project_max_width = 0.5,
      project_max_height = 0.5,
      keys = {
        quit = '<C-k>',
        exec = '<CR>',
        select = 'x',
      },
    },
    symbol_in_winbar = {
      enable = false,
      separator = ' › ',
      hide_keyword = false,
      ignore_patterns = nil,
      show_file = true,
      color_mode = true,
      delay = 300,
    },
    outline = {
      win_position = 'right',
      win_width = 30,
      auto_enter = true,
      auto_close = true,
      auto_preview = false,
      virt_text = '┃',
      jump_key = '<enter>',
      -- auto refresh when change buffer
      auto_refresh = true,
      keys = {
        toggle_or_jump = { 'l', '<cr>' },
        quit = 'q',
        jump = 'e',
      },
    },
    callhierarchy = {
      layout = 'float',
      left_width = 0.2,
      keys = {
        edit = 'e',
        vsplit = 's',
        split = 'i',
        tabe = 't',
        close = '<C-c>k',
        quit = 'q',
        shuttle = '[w',
        toggle_or_req = 'u',
      },
    },
    implement = {
      enable = false,
      sign = true,
      lang = {},
      virtual_text = true,
      priority = 100,
    },
    beacon = {
      enable = true,
      frequency = 7,
    },
    floaterm = {
      height = 0.7,
      width = 0.7,
    },
  })
end
