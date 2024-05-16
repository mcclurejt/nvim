-- TODO: move filename, filetype, diagnostics to winbar
-- TODO: disable statusline on inactive windows
return function()
  local nonicons_icons = require('nvim-nonicons')
  local clrs = require('catppuccin.palettes').get_palette('mocha')
  local conditions = require('heirline.conditions')
  local utils = require('heirline.utils')

  local function setup_colors()
    return {
      bg = utils.get_highlight('Normal').bg,
      fg = utils.get_highlight('Normal').fg,
      bright_bg = utils.get_highlight('Folded').bg,
      bright_fg = utils.get_highlight('Folded').fg,
      red = utils.get_highlight('DiagnosticError').fg,
      dark_red = utils.get_highlight('DiffDelete').bg,
      green = utils.get_highlight('String').fg,
      blue = utils.get_highlight('Function').fg,
      gray = utils.get_highlight('NonText').fg,
      orange = utils.get_highlight('Constant').fg,
      purple = utils.get_highlight('Statement').fg,
      pink = utils.get_highlight('Special').fg,
      diag_warn = utils.get_highlight('DiagnosticWarn').fg,
      diag_error = utils.get_highlight('DiagnosticError').fg,
      diag_hint = utils.get_highlight('DiagnosticHint').fg,
      diag_info = utils.get_highlight('DiagnosticInfo').fg,
      git_del = utils.get_highlight('GitSignsDelete').fg,
      git_add = utils.get_highlight('GitSignsAdd').fg,
      git_change = utils.get_highlight('GitSignsChange').fg,
    }
  end
  require('heirline').load_colors(setup_colors())

  local ViMode = {
    -- get vim current mode, this information will be required by the provider
    -- and the highlight functions, so we compute it only once per component
    -- evaluation and store it as a component attribute
    init = function(self)
      self.mode = vim.fn.mode(1) -- :h mode()
    end,
    -- Now we define some dictionaries to map the output of mode() to the
    -- corresponding string and color. We can put these into `static` to compute
    -- them at initialisation time.
    static = {
      mode_names = { -- change the strings if you like it vvvvverbose!
        n = 'N',
        no = 'N?',
        nov = 'N?',
        noV = 'N?',
        ['no\22'] = 'N?',
        niI = 'Ni',
        niR = 'Nr',
        niV = 'Nv',
        nt = 'Nt',
        v = 'V',
        vs = 'Vs',
        V = 'V_',
        Vs = 'Vs',
        ['\22'] = '^V',
        ['\22s'] = '^V',
        s = 'S',
        S = 'S_',
        ['\19'] = '^S',
        i = 'I',
        ic = 'Ic',
        ix = 'Ix',
        R = 'R',
        Rc = 'Rc',
        Rx = 'Rx',
        Rv = 'Rv',
        Rvc = 'Rv',
        Rvx = 'Rv',
        c = 'C',
        cv = 'Ex',
        r = '...',
        rm = 'M',
        ['r?'] = '?',
        ['!'] = '!',
        t = 'T',
      },
      mode_colors = {
        n = 'blue',
        i = 'green',
        v = 'purple',
        V = 'purple',
        ['\22'] = 'purple',
        c = 'orange',
        s = 'pink',
        S = 'pink',
        ['\19'] = 'pink',
        R = 'orange',
        r = 'orange',
        ['!'] = clrs.lavender,
        t = clrs.lavender,
      },
    },
    -- We can now access the value of mode() that, by now, would have been
    -- computed by `init()` and use it to index our strings dictionary.
    -- note how `static` fields become just regular attributes once the
    -- component is instantiated.
    -- To be extra meticulous, we can also add some vim statusline syntax to
    -- control the padding and make sure our string is always at least 2
    -- characters long. Plus a nice Icon.
    provider = function(self)
      -- return '󰣐 %2(' .. self.mode_names[self.mode] .. '%)'
      return ' ' .. nonicons_icons.get('heart-fill') .. '  '
    end,
    -- Same goes for the highlight. Now the foreground will change according to the current mode.
    hl = function(self)
      local mode = self.mode:sub(1, 1) -- get only the first mode character
      return { fg = 'bg', bg = self.mode_colors[mode], bold = true }
    end,
    -- Re-evaluate the component only on ModeChanged event!
    -- Also allows the statusline to be re-evaluated when entering operator-pending mode
    update = {
      'ModeChanged',
      pattern = '*:*',
      callback = vim.schedule_wrap(function()
        vim.cmd('redrawstatus')
      end),
    },
  }

  local FileNameBlock = {
    -- let's first set up some attributes needed by this component and it's children
    init = function(self)
      self.filename = vim.api.nvim_buf_get_name(0)
    end,
  }
  -- We can now define some children separately and add them later

  local FileIcon = {
    init = function(self)
      local filename = self.filename
      local extension = vim.fn.fnamemodify(filename, ':e')
      self.icon, self.icon_color = require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
    end,
    provider = function(self)
      return self.icon and (self.icon .. ' ')
    end,
    hl = function(self)
      return { fg = self.icon_color }
    end,
  }

  local FileName = {
    init = function(self)
      self.lfilename = vim.fn.fnamemodify(self.filename, ':.')
      if self.lfilename == '' then
        self.lfilename = '[No Name]'
      end
    end,
    hl = function()
      if not conditions.is_active() then
        return { fg = 'bright_fg', force = true }
      end
      return { fg = 'fg' }
    end,

    flexible = 2,

    {
      provider = function(self)
        return self.lfilename
      end,
    },
    {
      provider = function(self)
        return vim.fn.pathshorten(self.lfilename)
      end,
    },
  }
  -- local FileName = {
  --   provider = function(self)
  --     -- first, trim the pattern relative to the current directory. For other
  --     -- options, see :h filename-modifers
  --     local filename = vim.fn.fnamemodify(self.filename, ":.")
  --     if filename == "" then return "[No Name]" end
  --     -- now, if the filename would occupy more than 1/4th of the available
  --     -- space, we trim the file path to its initials
  --     -- See Flexible Components section below for dynamic truncation
  --     if not conditions.width_percent_below(#filename, 0.25) then
  --       filename = vim.fn.pathshorten(filename)
  --     end
  --     return filename
  --   end,
  --   hl = { fg = "rosewater" },
  -- }

  local FileFlags = {
    {
      condition = function()
        return vim.bo.modified
      end,
      provider = '[+]',
      hl = { fg = 'green' },
    },
    {
      condition = function()
        return not vim.bo.modifiable or vim.bo.readonly
      end,
      provider = '',
      hl = { fg = 'orange' },
    },
  }

  -- Now, let's say that we want the filename color to change if the buffer is
  -- modified. Of course, we could do that directly using the FileName.hl field,
  -- but we'll see how easy it is to alter existing components using a "modifier"
  -- component

  local FileNameModifer = {
    hl = function()
      if vim.bo.modified and conditions.is_active() then
        -- use `force` because we need to override the child's hl foreground
        return { fg = clrs.flamingo, bold = true, italic = false, force = true }
      end
    end,
  }

  -- let's add the children to our FileNameBlock component
  FileNameBlock = utils.insert(
    FileNameBlock,
    -- FileIcon,
    utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
    -- FileFlags,
    { provider = '%<' } -- this means that the statusline is cut here when there's not enough space
  )

  local FileType = {
    provider = function()
      return ' ' .. string.lower(vim.bo.filetype) .. ' '
    end,
    hl = { fg = 'bright_fg', bold = true },
  }

  -- FileType = utils.surround({ '', '' }, 'bg', { FileType })

  local FileEncoding = {
    provider = function()
      local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc -- :h 'enc'
      return enc ~= 'utf-8' and enc:upper()
    end,
  }

  local FileFormat = {
    provider = function()
      local fmt = vim.bo.fileformat
      return fmt ~= 'unix' and fmt:upper()
    end,
  }

  local FileSize = {
    provider = function()
      -- stackoverflow, compute human readable file size
      local suffix = { 'b', 'k', 'M', 'G', 'T', 'P', 'E' }
      local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
      fsize = (fsize < 0 and 0) or fsize
      if fsize < 1024 then
        return fsize .. suffix[1]
      end
      local i = math.floor((math.log(fsize) / math.log(1024)))
      return string.format('%.2g%s', fsize / math.pow(1024, i), suffix[i + 1])
    end,
  }

  local FileLastModified = {
    -- did you know? Vim is full of functions!
    provider = function()
      local ftime = vim.fn.getftime(vim.api.nvim_buf_get_name(0))
      return (ftime > 0) and os.date('%c', ftime)
    end,
  }

  -- I take no credits for this! :lion:
  local ScrollBar = {
    static = {
      sbar = { '', '', '', '', '' },
      -- sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' }
      -- Another variant, because the more choice the better.
      -- sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' }
    },
    provider = function(self)
      local curr_line = vim.api.nvim_win_get_cursor(0)[1]
      local lines = vim.api.nvim_buf_line_count(0)
      local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
      -- return " " .. string.rep(self.sbar[i], 2) .. " "
      return ' ' .. self.sbar[i] .. ' '
    end,
    hl = { fg = 'blue' },
  }

  -- ScrollBar = utils.surround({ '', '' }, 'bg', { ScrollBar })

  local LSPActive = {
    condition = conditions.lsp_attached,
    update = { 'LspAttach', 'LspDetach' },

    -- You can keep it simple,
    provider = ' [LSP]',

    -- Or complicate things a bit and get the servers names
    -- provider  = function()
    --   local names = {}
    --   for i, server in pairs(vim.lsp.get_active_clients(0)) do
    --     table.insert(names, server.name)
    --   end
    --   return " [" .. table.concat(names, " ") .. "]"
    -- end,
    hl = { fg = 'green', bold = true },
  }

  -- I personally use it only to display progress messages!
  -- See lsp-status/README.md for configuration options.

  -- Note: check "j-hui/fidget.nvim" for a nice statusline-free alternative.
  local LSPMessages = {
    provider = require('lsp-status').status,
    hl = { fg = 'gray' },
  }

  local Diagnostics = {

    condition = conditions.has_diagnostics,
    static = {
      error_icon = nonicons_icons.get('stop') .. ' ',
      warn_icon = nonicons_icons.get('alert') .. ' ',
      info_icon = nonicons_icons.get('info') .. ' ',
      hint_icon = nonicons_icons.get('light-bulb') .. ' ',
    },
    -- static = {
    --   error_icon = vim.fn.sign_getdefined('DiagnosticSignError')[1].text,
    --   warn_icon = vim.fn.sign_getdefined('DiagnosticSignWarn')[1].text,
    --   info_icon = vim.fn.sign_getdefined('DiagnosticSignInfo')[1].text,
    --   hint_icon = vim.fn.sign_getdefined('DiagnosticSignHint')[1].text,
    -- },

    init = function(self)
      self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
      self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
      self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
      self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,

    update = { 'DiagnosticChanged', 'BufEnter' },

    {
      provider = ' ',
    },
    {
      provider = function(self)
        -- 0 is just another output, we can decide to print it or not!
        return self.errors > 0 and (self.error_icon .. self.errors)
      end,
      hl = { fg = 'diag_error' },
    },
    {
      condition = function(self)
        local errors = self.errors and self.errors > 0
        local warnings = self.warnings and self.warnings > 0
        local info = self.info and self.info > 0
        local hints = self.hints and self.hints > 0
        return errors and (warnings or info or hints)
      end,
      provider = ' ',
    },
    {
      provider = function(self)
        return self.warnings > 0 and (self.warn_icon .. self.warnings)
      end,
      hl = { fg = 'diag_warn' },
    },
    {
      condition = function(self)
        local warnings = self.warnings and self.warnings > 0
        local info = self.info and self.info > 0
        local hints = self.hints and self.hints > 0
        return warnings and (info or hints)
      end,
      provider = ' ',
    },
    {
      provider = function(self)
        return self.info > 0 and (self.info_icon .. self.info)
      end,
      hl = { fg = 'diag_info' },
    },
    {
      condition = function(self)
        local info = self.info and self.info > 0
        local hints = self.hints and self.hints > 0
        return info and hints
      end,
      provider = ' ',
    },
    {
      provider = function(self)
        return self.hints > 0 and (self.hint_icon .. self.hints)
      end,
      hl = { fg = 'diag_hint' },
    },
    {
      provider = ' ',
    },
  }

  -- Diagnostics = utils.surround({ '', '' }, 'bg', { Diagnostics })

  local Git = {
    condition = conditions.is_git_repo,

    init = function(self)
      self.status_dict = vim.b.gitsigns_status_dict
      self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,

    hl = { fg = 'bright_fg' },

    { -- git branch name
      provider = function(self)
        -- return '  ' .. self.status_dict.head .. ' '
        return ' ' .. nonicons_icons.get('git-branch') .. ' ' .. self.status_dict.head .. ' '
      end,
      hl = { bold = true },
    },
    -- You could handle delimiters, icons and counts similar to Diagnostics
    -- {
    --   condition = function(self)
    --     return self.has_changes
    --   end,
    --   provider = ""
    -- },
    -- {
    --   provider = function(self)
    --     local count = self.status_dict.added or 0
    --     return count > 0 and (" 󰜄 " .. count)
    --   end,
    --   hl = { fg = "green" },
    -- },
    -- {
    --   provider = function(self)
    --     local count = self.status_dict.removed or 0
    --     return count > 0 and (" 󰛲 " .. count)
    --   end,
    --   hl = { fg = "red" },
    -- },
    -- {
    --   provider = function(self)
    --     local count = self.status_dict.changed or 0
    --     return count > 0 and (" 󰏭 " .. count)
    --   end,
    --   hl = { fg = "yellow" },
    -- },
    -- {
    --   condition = function(self)
    --     return self.has_changes
    --   end,
    --   provider = " ",
    -- },
  }
  -- Git = utils.surround({ '', '' }, 'bg', { Git })

  local GitStatus = {
    condition = conditions.is_git_repo,
    init = function(self)
      self.status_dict = vim.b.gitsigns_status_dict
      self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,
    {
      condition = function(self)
        return self.has_changes
      end,
      provider = '',
    },
    {
      provider = function(self)
        local count = self.status_dict.added or 0
        return count > 0 and (nonicons_icons.get('diff-added') .. ' ' .. count)
      end,
      hl = { fg = 'git_add' },
    },
    {
      condition = function(self)
        local added = self.status_dict.added or 0
        local changed = self.status_dict.changed or 0
        local removed = self.status_dict.removed or 0
        return added > 0 and (changed > 0 or removed > 0)
      end,
      provider = ' ',
    },
    {
      provider = function(self)
        local count = self.status_dict.changed or 0
        return count > 0 and (nonicons_icons.get('diff-modified') .. ' ' .. count)
      end,
      hl = { fg = 'git_change' },
    },
    {
      condition = function(self)
        local changed = self.status_dict.changed or 0
        local removed = self.status_dict.removed or 0
        return changed > 0 and removed > 0
      end,
      provider = ' ',
    },
    {
      provider = function(self)
        local count = self.status_dict.removed or 0
        return count > 0 and (nonicons_icons.get('diff-removed') .. ' ' .. count)
      end,
      hl = { fg = 'git_del' },
    },
    {
      condition = function(self)
        return self.has_changes
      end,
      provider = '',
    },
  }
  -- GitStatus = utils.surround({ '', '' }, 'bg', { GitStatus })

  local WorkDir = {
    init = function(self)
      self.icon = (vim.fn.haslocaldir(0) == 1 and 'l' or 'g') .. ' ' .. ' '
      local cwd = vim.fn.getcwd(0)
      self.cwd = vim.fn.fnamemodify(cwd, ':~')
    end,
    hl = { fg = 'blue', bold = true },

    flexible = 1,

    {
      -- evaluates to the full-lenth path
      provider = function(self)
        local trail = self.cwd:sub(-1) == '/' and '' or '/'
        return self.icon .. self.cwd .. trail .. ' '
      end,
    },
    {
      -- evaluates to the shortened path
      provider = function(self)
        local cwd = vim.fn.pathshorten(self.cwd)
        local trail = self.cwd:sub(-1) == '/' and '' or '/'
        return self.icon .. cwd .. trail .. ' '
      end,
    },
    {
      -- evaluates to "", hiding the component
      provider = '',
    },
  }

  local SearchCount = {
    condition = function()
      return vim.v.hlsearch ~= 0 and vim.o.cmdheight == 0
    end,
    init = function(self)
      local ok, search = pcall(vim.fn.searchcount)
      if ok and search.total then
        self.search = search
      end
    end,
    provider = function(self)
      local search = self.search
      return string.format('[%d/%d]', search.current, math.min(search.total, search.maxcount))
    end,
  }

  local MacroRec = {
    condition = function()
      return vim.fn.reg_recording() ~= '' and vim.o.cmdheight == 0
    end,
    provider = ' ',
    hl = { fg = 'orange', bold = true },
    utils.surround({ '[', ']' }, nil, {
      provider = function()
        return vim.fn.reg_recording()
      end,
      hl = { fg = 'green', bold = true },
    }),
    update = {
      'RecordingEnter',
      'RecordingLeave',
    },
  }

  vim.opt.showcmdloc = 'statusline'
  local ShowCmd = {
    condition = function()
      return vim.o.cmdheight == 0
    end,
    provider = ':%3.5(%S%)',
  }

  local Align = { provider = '%=' }
  local Space = { provider = ' ' }

  local HelpFileName = {
    condition = function()
      return vim.bo.filetype == 'help'
    end,
    provider = function()
      local filename = vim.api.nvim_buf_get_name(0)
      return vim.fn.fnamemodify(filename, ':t')
    end,
    hl = { fg = 'blue' },
  }

  local TerminalName = {
    -- we could add a condition to check that buftype == 'terminal'
    -- or we could do that later (see #conditional-statuslines below)
    provider = function()
      local tname, _ = vim.api.nvim_buf_get_name(0):gsub('.*:', '')
      return ' ' .. tname
    end,
    hl = { fg = 'bg', bold = true },
  }

  ViMode = utils.surround({ '', '' }, function(self)
    return self:mode_color()
  end, { ViMode })

  local DefaultStatusline = {
    ViMode,
    Space,
    Git,
    Space,
    GitStatus,
    Space,
    Align,
    FileNameBlock,
    Align,
    Space,
    Diagnostics,
    Space,
    FileType,
    -- Space,
    -- ScrollBar,
    Space,
    ViMode,
  }

  local InactiveStatusline = {
    condition = conditions.is_not_active,
    Align,
    FileNameBlock,
    Align,
  }

  local SpecialStatusline = {
    condition = function()
      return conditions.buffer_matches({
        buftype = { 'nofile', 'prompt', 'help', 'quickfix' },
        filetype = { '^git.*', 'fugitive' },
      })
    end,

    FileType,
    Space,
    HelpFileName,
    Align,
  }

  local TerminalStatusline = {

    condition = function()
      return conditions.buffer_matches({ buftype = { 'terminal' } })
    end,

    hl = { bg = clrs.lavender, fg = 'bg' },

    -- Quickly add a condition to the ViMode to only show it when buffer is active!
    { condition = conditions.is_active, ViMode, Space },
    -- FileType,
    Space,
    TerminalName,
    Align,
  }

  local TablineBufnr = {
    provider = function(self)
      return tostring(self.bufnr) .. '. '
    end,
    hl = 'Comment',
  }

  local TablineFileName = {
    provider = function(self)
      -- self.filename will be defined later, just keep looking at the example!
      local filename = self.filename
      filename = filename == '' and '[No Name]' or vim.fn.fnamemodify(filename, ':t')
      return filename
    end,
    hl = function(self)
      return { bold = self.is_active or self.is_visible, italic = true }
    end,
  }

  local TablineFileNameBlock = {
    init = function(self)
      self.filename = vim.api.nvim_buf_get_name(self.bufnr)
    end,
    hl = function(self)
      if self.is_active then
        return 'TabLineSel'
        -- why not?
        -- elseif not vim.api.nvim_buf_is_loaded(self.bufnr) then
        --     return { fg = "gray" }
      else
        return 'TabLine'
      end
    end,
    on_click = {
      callback = function(_, minwid, _, button)
        if button == 'm' then -- close on mouse middle click
          vim.schedule(function()
            vim.api.nvim_buf_delete(minwid, { force = false })
          end)
        else
          vim.api.nvim_win_set_buf(0, minwid)
        end
      end,
      minwid = function(self)
        return self.bufnr
      end,
      name = 'heirline_tabline_buffer_callback',
    },
    TablineBufnr,
    FileIcon, -- turns out the version defined in #crash-course-part-ii-filename-and-friends can be reutilized as is here!
    TablineFileName,
  }

  local TablineBufferBlock = utils.surround({ '', '' }, function(self)
    if self.is_active then
      return utils.get_highlight('TabLineSel').bg
    else
      return utils.get_highlight('TabLine').bg
    end
  end, { TablineFileNameBlock })

  local StatusLines = {

    hl = function()
      if conditions.is_active() then
        return 'StatusLine'
      else
        return 'StatusLine'
      end
    end,

    -- the first statusline with no condition, or which condition returns true is used.
    -- think of it as a switch case with breaks to stop fallthrough.
    fallthrough = false,

    SpecialStatusline,
    TerminalStatusline,
    InactiveStatusline,
    DefaultStatusline,
    static = {
      mode_colors = {
        n = 'blue',
        i = 'green',
        v = 'purple',
        V = 'purple',
        ['\22'] = 'purple',
        c = 'orange',
        s = 'pink',
        S = 'pink',
        ['\19'] = 'pink',
        R = 'orange',
        r = 'orange',
        ['!'] = clrs.lavender,
        t = clrs.lavender,
      },
      mode_color = function(self)
        local mode = conditions.is_active() and vim.fn.mode() or 'n'
        return self.mode_colors[mode]
      end,
    },
  }

  local BufferLine = utils.make_buflist(
    TablineBufferBlock,
    { provider = '', hl = { fg = 'gray' } }, -- left truncation, optional (defaults to "<")
    { provider = '', hl = { fg = 'gray' } } -- right trunctation, also optional (defaults to ...... yep, ">")
    -- by the way, open a lot of buffers and try clicking them ;)
  )
  require('heirline').setup({
    statusline = StatusLines,

    opts = {
      -- if the callback returns true, the winbar will be disabled for that window
      -- the args parameter corresponds to the table argument passed to autocommand callbacks. :h nvim_lua_create_autocmd()
      disable_winbar_cb = function(args)
        return conditions.buffer_matches({
          buftype = { 'nofile', 'prompt', 'help', 'quickfix' },
          filetype = { '^git.*', 'fugitive', 'Trouble', 'dashboard' },
        }, args.buf)
      end,
    },
  })
end
