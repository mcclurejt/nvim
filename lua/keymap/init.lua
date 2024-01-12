local keymap = require('core.keymap')
local nmap, imap, cmap, vmap, xmap, tmap = keymap.nmap, keymap.imap, keymap.cmap, keymap.vmap, keymap.xmap, keymap.tmap
local silent, noremap = keymap.silent, keymap.noremap
local opts = keymap.new_opts
local cmd = keymap.cmd

-- Use space as leader key
vim.g.mapleader = ' '

-------------------------------------------------------------------------------
-- Basics
-------------------------------------------------------------------------------

-- leaderkey
nmap({ ' ', '', opts(noremap) })
xmap({ ' ', '', opts(noremap) })

-- i dont use macros
nmap({ 'q', '', opts(silent) })
xmap({ 'q', '', opts(silent) })

-- 'jk' leave insert mode
imap({ 'jk', '<esc>', opts(noremap, 'Escape') })
xmap({ 'jk', '<esc>', opts(noremap, 'Escape') })

-- ';' commandline
nmap({ ';', ':', opts(noremap, 'CMD') })

-- write
nmap({ '<leader>w', cmd('w'), opts(noremap, 'Save') })

-- quit
nmap({ '<leader>q', cmd('qa!'), opts(noremap, 'Quit all') })
vmap({ '<leader>q', cmd('qa!'), opts(noremap, 'Quit all') })

-- end of line
nmap({ '<c-e>', '<End>', opts(noremap, silent, 'End') })
vmap({ '<c-e>', '<End>', opts(noremap, silent, 'End') })

-- highlights
nmap({ '<esc>', '<esc>:noh<cr>', opts(noremap, silent, 'Clear Highlights') })

-- indenting
vmap({ '<', '<gv', opts(noremap, silent) })
vmap({ '>', '>gv', opts(noremap, silent) })

-- move lines
nmap({ '<A-j>', '<cmd>m .+1<cr>==', opts(noremap, silent, 'Move Down') })
nmap({ '<A-k>', '<cmd>m .-2<cr>==', opts(noremap, silent, 'Move Up') })
imap({ '<A-j>', '<esc><cmd>m .+1<cr>==gi', opts(noremap, silent, 'Move Down') })
imap({ '<A-k>', '<esc><cmd>m .-2<cr>==gi', opts(noremap, silent, 'Move Up') })
vmap({ '<A-j>', ":m '>+1<cr>gv=gv", opts(noremap, silent, 'Move Down') })
vmap({ '<A-k>', ":m '>-2<cr>gv=gv", opts(noremap, silent, 'Move Up') })
-------------------------------------------------------------------------------
-- Windows
-------------------------------------------------------------------------------

-- x/v splits
nmap({ '<leader>x', '<c-w>s', opts(noremap, 'H-Split') })
nmap({ '<leader>v', '<c-w>v', opts(noremap, 'V-Split') })

-------------------------------------------------------------------------------
-- Files
-------------------------------------------------------------------------------

-- Sidebar Explorer
nmap({
  '<leader>e',
  function()
    require('neo-tree.command').execute({ toggle = true, dir = vim.loop.cwd(), reveal = true })
  end,
  opts(noremap, ' Explorer'),
})

-- Project Drawer
nmap({
  '-',
  cmd('lua MiniFiles.open()'),
  opts(noremap, silent, 'Project Drawer'),
})

-------------------------------------------------------------------------------
-- Buffers
-------------------------------------------------------------------------------

nmap({
  '<leader>c',
  cmd('bd'),
  opts(noremap, 'Close Buffer'),
})

nmap({
  '<Tab>',
  cmd('Neotree float buffers selector=false'),
  opts(silent, noremap),
})

-------------------------------------------------------------------------------
-- LSP
-------------------------------------------------------------------------------

nmap({
  { ']d',         cmd('Lspsaga diagnostic_jump_next'),       opts(silent, noremap, 'Next Diagnostic') },
  { '[d',         cmd('Lspsaga diagnostic_jump_prev'),       opts(silent, noremap, 'Prev Diagnostic') },
  { 'K',          cmd('Lspsaga hover_doc'),                  opts(silent, noremap, 'Hover Docs') },
  { 'ga',         cmd('Lspsaga code_action'),                opts(silent, noremap, 'Code Actions') },
  { 'gd',         cmd('Lspsaga peek_definition'),            opts(silent, noremap, 'Peek Definition') },
  { 'gp',         cmd('Lspsaga goto_definition'),            opts(silent, noremap, 'Goto Definition') },
  { 'gr',         cmd('Lspsaga rename'),                     opts(silent, noremap, 'Rename') },
  { 'gh',         cmd('Lspsaga finder'),                     opts(silent, noremap, 'Finder') },
  { 'gx',         cmd('Lspsaga show_line_diagnostics'),      opts(silent, noremap, 'Line Diagnostics') },
  { '<Leader>o',  cmd('Lspsaga outline'),                    opts(silent, noremap, 'Outline') },
  { '<Leader>dw', cmd('Lspsaga show_workspace_diagnostics'), opts(silent, noremap, 'Workspace Diagnostics') },
  { '<Leader>db', cmd('Lspsaga show_buf_diagnostics'),       opts(silent, noremap, 'Buffer Diagnostics') },
})
xmap({
  'ga',
  cmd('Lspsaga range_code_action'),
  opts(silent, noremap, 'Code Actions'),
})

-------------------------------------------------------------------------------
-- Term
-------------------------------------------------------------------------------
nmap({
  '<c-cr>',
  cmd('Lspsaga term_toggle'),
  opts(silent, noremap),
})
tmap({
  {
    '<esc>',
    [[<c-\><c-n>]],
    opts(),
  },
  {
    '<c-cr>',
    cmd('Lspsaga term_toggle'),
    opts(silent, noremap),
  },
})
