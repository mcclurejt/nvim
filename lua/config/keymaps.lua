-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", ";", ":", { desc = "Cmdline" })

-- No accidental macros
vim.keymap.set({ "n" }, "q", "<Nop>")
vim.keymap.set({ "n" }, "Q", "q")

-- No accidental marks
vim.keymap.set({ "n" }, "m", "<Nop>")

-- Save
vim.keymap.set({ "x", "n", "s" }, "<leader>W", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Next/Prev Buffer
-- vim.keymap.set({ "n" }, "<tab>", "<cmd>bn<cr>", { desc = "Next Buffer" })
-- vim.keymap.set({ "n" }, "<s-tab>", "<cmd>bp<cr>", { desc = "Previous Buffer" })

-- Buffer Search
-- vim.keymap.set({ "n" }, ",,", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", { desc = "List Buffers" })

-- Modify yank behavior
vim.keymap.set({ "n", "x" }, "c", '"_c', { desc = "Change without Yanking" })
vim.keymap.set({ "n", "x" }, "C", '"_C', { desc = "Change without Yanking" })
vim.keymap.set({ "x" }, "p", "P", { desc = "Paste without Yanking" })
vim.keymap.set({ "x" }, "P", "p", { desc = "Yank then Paste" })

-- Folds
-- vim.keymap.set({ "n" }, "zj", "zm", { desc = "Fold More" })
-- vim.keymap.set({ "n" }, "zk", "zr", { desc = "Fold Less" })

-- Cmdline auto completion
vim.keymap.set({ "c" }, "<c-k>", function()
  return vim.fn.wildmenumode() == 1 and "<Left>" or "<Up>"
end, { desc = "Wildmenu Fix", expr = true, noremap = true })
vim.keymap.set({ "c" }, "<c-j>", function()
  return vim.fn.wildmenumode() == 1 and "<Right>" or "<Down>"
end, { desc = "Wildmenu Fix", expr = true, noremap = true })

-- Terminal
vim.keymap.set({ "n" }, "<c-cr>", function()
  Snacks.terminal()
end, { desc = "Toggle Terminal" })
vim.keymap.set({ "t" }, "<c-cr>", "<cmd>close<cr>", { desc = "Close Window" })
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- Jumplist
vim.keymap.set({ "n" }, "<c-[>", "<c-o>", { desc = "Jump Back" })
vim.keymap.set({ "n" }, "<c-]>", "<c-i>", { desc = "Jump Forward" })

-- Move a lil in insert mode
vim.keymap.set({ "i" }, "<c-h>", "<c-o>h", { desc = "Move Left" })
-- vim.keymap.set({ "i" }, "<c-j>", "<c-o>gj", { desc = "Move Down" })
-- vim.keymap.set({ "i" }, "<c-k>", "<c-o>gk", { desc = "Move Up" })
vim.keymap.set({ "i" }, "<c-l>", "<c-o>l", { desc = "Move Right" })

-- LSP Hover Doc Scroll
-- vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
--   if not require("noice.lsp").scroll(4) then
--     return "<c-f>"
--   end
-- end, { silent = true, expr = true })
--
-- vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
--   if not require("noice.lsp").scroll(-4) then
--     return "<c-b>"
--   end
-- end, { silent = true, expr = true })
