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
imap({ 'jk', '<esc>', opts(noremap, silent, 'Escape') })
-- xmap({ 'jk', '<esc>', opts(noremap, silent, 'Escape') })

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

-- jumplist
-- nmap({
--   '<c-]>',
--   ']j',
--   opts(noremap, silent, 'Jump Forward'),
-- })
-- nmap({
--   '<c-[>',
--   '[j',
--   opts(noremap, silent, 'Jump Backward'),
-- })

-- H/L ->Line Beginning/End
nmap({ 'H', '0', opts(noremap, silent, 'Line Beginning') })
nmap({ 'L', '$', opts(noremap, silent, 'Line End') })

-- Enter -> Change word
-- nmap({ '<enter>', 'ciw', opts(noremap, silent, 'Change Word') })

-- zj/zk -> Fold more/less
nmap({ 'zj', 'zm', opts(noremap, silent, 'Fold More') })
nmap({ 'zk', 'zr', opts(noremap, silent, 'Fold Less') })

-- nmap({
--   'zm',
--   function()
--     require('ufo').closeAllFolds()
--   end,
--   opts(noremap, silent, 'Close all Folds'),
-- })
--
-- nmap({
--   'zM',
--   function()
--     require('ufo').closeAllFolds()
--   end,
--   opts(noremap, silent, 'Close all Folds'),
-- })
--
-- nmap({
--   'z1',
--   function()
--     require('ufo').closeFoldsWith(1)
--   end,
--   opts(noremap, silent, 'Fold More 1'),
-- })
--
-- nmap({
--   'z2',
--   function()
--     require('ufo').closeFoldsWith(2)
--   end,
--   opts(noremap, silent, 'Fold More 2'),
-- })
--
-- nmap({
--   'z3',
--   function()
--     require('ufo').closeFoldsWith(3)
--   end,
--   opts(noremap, silent, 'Fold More 3'),
-- })
--
-- nmap({
--   'z4',
--   function()
--     require('ufo').closeFoldsWith(4)
--   end,
--   opts(noremap, silent, 'Fold More 4'),
-- })
--
-- nmap({
--   'zR',
--   function()
--     require('ufo').openAllFolds()
--   end,
--   opts(noremap, silent, 'Open all Folds'),
-- })
--
-- nmap({
--   'zr',
--   function()
--     require('ufo').openFoldsExceptKinds({ 'comment', 'imports' })
--   end,
--   opts(noremap, silent, 'Fold Less'),
-- })

-- nmap({
--   '<tab>',
--   function()
--     return require('fold-cycle').close()
--   end,
--   opts(noremap, silent, 'Fold-Cycle: Close folds'),
-- })

-- nmap({
--   '<s-tab>',
--   function()
--     return require('fold-cycle').open()
--   end,
--   opts(noremap, silent, 'Fold-Cycle: Open folds'),
-- })

-- nmap({
--   'zC',
--   function()
--     return require('fold-cycle').close_all()
--   end,
--   opts(noremap, silent, 'Fold-Cycle: Close all folds'),
-- })

-------------------------------------------------------------------------------
-- Windows
-------------------------------------------------------------------------------

-- x/v splits
nmap({ '<leader>sx', '<c-w>s', opts(noremap, 'H-Split') })
nmap({ '<leader>sv', '<c-w>v', opts(noremap, 'V-Split') })

-------------------------------------------------------------------------------
-- Files
-------------------------------------------------------------------------------

-- NvimTree
nmap({
  '-',
  function()
    local api = require('nvim-tree.api')
    api.tree.toggle({ focus = true })
  end,
  opts(noremap, 'NvimTree (Open in place)'),
})
nmap({
  '<leader>e',
  function()
    local api = require('nvim-tree.api')
    api.tree.toggle({ focus = true })
  end,
  opts(noremap, 'NvimTree'),
})
-- Neotree
-- nmap({ '<tab>', cmd('Neotree buffers reveal right toggle'), opts(noremap, silent, 'Neotree buffers') })

-------------------------------------------------------------------------------
-- Buffers
-------------------------------------------------------------------------------

nmap({
  '<leader>c',
  cmd('bd'),
  opts(noremap, 'Close Buffer'),
})
-- nmap({
--   '<tab>',
--   cmd('bn'),
--   opts('Next Buffer'),
-- })
-- nmap({
--   '<s-tab>',
--   cmd('bp'),
--   opts('Previous Buffer'),
-- })
-------------------------------------------------------------------------------
-- LSP
-------------------------------------------------------------------------------
imap({ '<c-space>', cmd('lua vim.lsp.buf.omnifunc()'), opts(silent, noremap, 'Auto-Complete') })
nmap({
  { ']x', cmd('Lspsaga diagnostic_jump_next'), opts(silent, noremap, 'Next Diagnostic') },
  { '[x', cmd('Lspsaga diagnostic_jump_prev'), opts(silent, noremap, 'Prev Diagnostic') },
  { 'K', cmd('Lspsaga hover_doc'), opts(silent, noremap, 'Hover Docs') },
  { 'ga', cmd('Lspsaga code_action'), opts(silent, noremap, 'Code Actions') },
  { 'gd', cmd('Lspsaga peek_definition'), opts(silent, noremap, 'Peek Definition') },
  { 'gy', cmd('Lspsaga peek_type_definition'), opts(silent, noremap, 'Peek Type Definition') },
  { 'gD', cmd('Lspsaga goto_definition'), opts(silent, noremap, 'Goto Definition') },
  { 'gr', cmd('Lspsaga rename'), opts(silent, noremap, 'Rename') },
  { 'gh', cmd('Lspsaga finder'), opts(silent, noremap, 'Finder') },
  { 'gx', cmd('Lspsaga show_line_diagnostics'), opts(silent, noremap, 'Line Diagnostics') },
  -- { '<Leader>o', cmd('Lspsaga outline'), opts(silent, noremap, 'Outline') },
  { '<Leader>X', cmd('Lspsaga show_workspace_diagnostics'), opts(silent, noremap, 'Workspace Diagnostics') },
  { '<Leader>x', cmd('Lspsaga show_buf_diagnostics'), opts(silent, noremap, 'Buffer Diagnostics') },
})
xmap({
  'ga',
  cmd('Lspsaga range_code_action'),
  opts(silent, noremap, 'Code Actions'),
})
nmap({ '<leader>o', cmd('Outline'), opts(silent, noremap, 'Outline (=)') })
nmap({ '=', cmd('Navbuddy'), opts(silent, noremap, 'Navbuddy') })

-------------------------------------------------------------------------------
-- Term
-------------------------------------------------------------------------------
-- normal mode in term
tmap({ '<esc><esc>', '<c-\\><c-n>', opts(silent, noremap) })
nmap({ '<c-cr>', cmd('Lspsaga term_toggle'), opts(silent, noremap, 'Toggle Terminal') })
tmap({ '<c-cr>', cmd('Lspsaga term_toggle'), opts(silent, noremap, 'Toggle Terminal') })

-------------------------------------------------------------------------------
-- Git
-------------------------------------------------------------------------------
nmap({ '<leader>gg', cmd('Lazygit'), opts(silent, noremap, 'Lazygit') })
nmap({ '<leader>gn', cmd('Neogit'), opts(silent, noremap, 'Neogit') })
nmap({ '<leader>gd', cmd('DiffviewOpen'), opts(silent, noremap, 'Diffview Open') })
nmap({ '<leader>gm', cmd('DiffviewOpen main'), opts(silent, noremap, 'Diffview Open (compare main)') })
nmap({ '<leader>gc', cmd('DiffviewClose'), opts(silent, noremap, 'Diffview Close') })

-------------------------------------------------------------------------------
-- Telescope
-------------------------------------------------------------------------------
nmap({
  { '<leader>fg', cmd('Telescope live_grep'), opts(noremap, 'Live Grep') },
  { '<leader>fs', cmd('lua require("spectre").toggle()'), opts(noremap, 'Spectre') },
  { '<leader><space>', cmd('Telescope live_grep'), opts(noremap, 'Search All') },
  { '<leader>ff', cmd('Telescope find_files'), opts(noremap, 'Find Files') },
  { '<leader>fb', cmd('Telescope buffers'), opts(noremap, 'Buffers') },
})

-------------------------------------------------------------------------------
-- Trouble
-------------------------------------------------------------------------------
nmap({ '<leader>tt', cmd('TodoTrouble'), opts(silent, noremap, 'Trouble (todos)') })
nmap({ '<leader>tx', cmd('TroubleToggle workspace_diagnostics'), opts(silent, noremap, 'Trouble (workspace)') })
nmap({ '<leader>tX', cmd('TroubleToggle document_diagnostics'), opts(silent, noremap, 'Trouble (document)') })
nmap({ '<leader>tq', cmd('TroubleToggle quickfix'), opts(silent, noremap, 'Trouble (quickfix)') })

-------------------------------------------------------------------------------
-- Minimap
-------------------------------------------------------------------------------
nmap({ '<leader>mc', MiniMap.close, opts(silent, noremap, 'MiniMap Close') })
nmap({ '<leader>mf', MiniMap.toggle_focus, opts(silent, noremap, 'MiniMap Toggle Focus') })
nmap({ '<leader>mo', MiniMap.open, opts(silent, noremap, 'MiniMap Open') })
nmap({ '<leader>mc', MiniMap.refresh, opts(silent, noremap, 'MiniMap Refresh') })
nmap({ '<leader>ms', MiniMap.toggle_side, opts(silent, noremap, 'MiniMap Toggle Side') })
nmap({ '<leader>mt', MiniMap.toggle, opts(silent, noremap, 'MiniMap Toggle') })

-------------------------------------------------------------------------------
-- Tmux
-------------------------------------------------------------------------------
-- nmap({ '<c-h>', cmd('NvimTmuxNavigateLeft'), opts(silent, noremap, 'Tmux Navigate Left') })
-- nmap({ '<c-j>', cmd('NvimTmuxNavigateDown'), opts(silent, noremap, 'Tmux Navigate Down') })
-- nmap({ '<c-k>', cmd('NvimTmuxNavigateUp'), opts(silent, noremap, 'Tmux Navigate Up') })
-- nmap({ '<c-l>', cmd('NvimTmuxNavigateRight'), opts(silent, noremap, 'Tmux Navigate Right') })
