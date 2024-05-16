local opt = vim.opt
local cache_dir = vim.env.HOME .. '/.cache/nvim/'

opt.termguicolors = true
opt.hidden = true
opt.magic = true
opt.virtualedit = 'block'
opt.clipboard = 'unnamedplus'
opt.wildignorecase = true
opt.swapfile = false
opt.directory = cache_dir .. 'swap/'
opt.undodir = cache_dir .. 'undo/'
opt.backupdir = cache_dir .. 'backup/'
opt.viewdir = cache_dir .. 'view/'
opt.spellfile = cache_dir .. 'spell/en.uft-8.add'
opt.history = 2000
opt.timeout = true
opt.ttimeout = true
opt.timeoutlen = 500
opt.ttimeoutlen = 10
opt.updatetime = 100
opt.redrawtime = 1500
opt.ignorecase = true
opt.smartcase = true
opt.infercase = true

if vim.fn.executable('rg') == 1 then
  opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
  opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
end

opt.completeopt = 'menu,menuone,noselect'
opt.showmode = false
opt.shortmess = 'aoOTIcF'
opt.scrolloff = 1000
opt.sidescrolloff = 10
opt.ruler = false
opt.winwidth = 30
opt.pumheight = 15
opt.showcmd = false

opt.cmdheight = 0
opt.laststatus = 3
opt.list = true
opt.listchars = 'tab:»·,nbsp:+,trail:·,extends:→,precedes:←'
opt.pumblend = 10
opt.winblend = 10
opt.undofile = true

opt.smarttab = true
opt.expandtab = true
opt.autoindent = true
opt.tabstop = 2
opt.shiftwidth = 2

-- wrap
opt.linebreak = true
opt.whichwrap = 'h,l,<,>,[,],~'
opt.breakindentopt = 'shift:2,min:20'
opt.showbreak = '↳ '

-- fold
opt.foldcolumn = '0'
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
-- vim.opt.foldtext = 'v:lua.vim.treesitter.foldtext()'

opt.number = true
-- opt.signcolumn = 'yes'
opt.spelloptions = 'camel'

-- sessions
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions,globals'

opt.textwidth = 100
opt.colorcolumn = ''
if vim.loop.os_uname().sysname == 'Darwin' then
  vim.g.clipboard = {
    name = 'macOS-clipboard',
    copy = {
      ['+'] = 'pbcopy',
      ['*'] = 'pbcopy',
    },
    paste = {
      ['+'] = 'pbpaste',
      ['*'] = 'pbpaste',
    },
    cache_enabled = 0,
  }
  vim.g.python_host_prog = '/usr/bin/python'
  vim.g.python3_host_prog = '/usr/local/bin/python3'
end

-- ui
opt.winbl = 0

-- fix nvim-tree restore from session
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = { 'NvimTree' },
--   callback = function(args)
--     vim.api.nvim_create_autocmd('VimLeavePre', {
--       callback = function()
--         vim.api.nvim_buf_delete(args.buf, { force = true })
--         return true
--       end,
--     })
--   end,
-- })
-- vim.api.nvim_create_autocmd({ 'BufEnter' }, {
--   pattern = 'NvimTree*',
--   callback = function()
--     local view = require('nvim-tree.view')
--     local is_visible = view.is_visible()
--     local api = require('nvim-tree.api')
--     if not is_visible then
--       api.tree.open()
--     end
--   end,
-- })

-- automatically set fold method
vim.api.nvim_create_autocmd({ 'FileType' }, {
  callback = function()
    if require('nvim-treesitter.parsers').has_parser() then
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    else
      vim.opt.foldmethod = 'syntax'
    end
  end,
})
function MyDeleteView()
  local path = vim.fn.fnamemodify(vim.fn.bufname('%'), ':p')
  -- vim's odd =~ escaping for /
  path = vim.fn.substitute(path, '=', '==', 'g')
  if vim.fn.has_key(vim.fn.environ(), 'HOME') then
    path = vim.fn.substitute(path, '^' .. os.getenv('HOME'), '\\~', '')
  end
  path = vim.fn.substitute(path, '/', '=+', 'g') .. '='
  -- view directory
  path = vim.opt.viewdir:get() .. path
  vim.fn.delete(path)
  print('Deleted: ' .. path)
end

function FixFolds()
  vim.cmd([[
        augroup remember_folds
          autocmd!
        augroup END
    ]])
  MyDeleteView()
  print('Close and reopen nvim for folds to work on this file again')
end

vim.api.nvim_create_user_command('FixFolds', FixFolds, {})
vim.api.nvim_create_user_command('Delview', MyDeleteView, {})

-- automatically resize the nvimtree when neovim's window size changes
local tree_api = require('nvim-tree')
local tree_view = require('nvim-tree.view')

vim.api.nvim_create_augroup('NvimTreeResize', {
  clear = true,
})

vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = 'NvimTreeResize',
  callback = function()
    if tree_view.is_visible() then
      tree_view.close()
      tree_api.open()
    end
  end,
})

-- themed feline
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    package.loaded['feline'] = nil
    package.loaded['catppuccin.groups.integrations.feline'] = nil
    require('feline').setup({
      components = require('catppuccin.groups.integrations.feline').get(),
    })
  end,
})

-- -- go to last used hidden buffer when deleting a buffer
-- vim.api.nvim_create_autocmd('BufEnter', {
--   nested = true,
--   callback = function()
--     local api = require('nvim-tree.api')
--
--     -- Only 1 window with nvim-tree left: we probably closed a file buffer
--     if #vim.api.nvim_list_wins() == 1 and api.tree.is_tree_buf() then
--       -- Required to let the close event complete. An error is thrown without this.
--       vim.defer_fn(function()
--         -- close nvim-tree: will go to the last hidden buffer used before closing
--         api.tree.toggle({ find_file = true, focus = true })
--         -- re-open nivm-tree
--         api.tree.toggle({ find_file = true, focus = true })
--         -- nvim-tree is still the active window. Go to the previous window.
--         vim.cmd('wincmd p')
--       end, 0)
--     end
--   end,
-- })
