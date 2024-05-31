-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", ";", ":", { desc = "Cmdline" })

-- No accidental macros
vim.keymap.set({ "n" }, "q", "<Nop>")
vim.keymap.set({ "n" }, "Q", "q")

-- Save
vim.keymap.del({ "n" }, "<leader>w|")
vim.keymap.del({ "n" }, "<leader>w-")
vim.keymap.del({ "n" }, "<leader>ww")
vim.keymap.del({ "n" }, "<leader>wd")
vim.keymap.set({ "x", "n", "s" }, "<leader>w", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Close Buffer Window
vim.keymap.set({ "n" }, "<leader>c", "<cmd>close<cr>", { desc = "Close Window" })

-- Next/Prev Buffer
-- vim.keymap.set({ "n" }, "<tab>", "<cmd>bn<cr>", { desc = "Next Buffer" })
-- vim.keymap.set({ "n" }, "<s-tab>", "<cmd>bp<cr>", { desc = "Previous Buffer" })

-- Modify yank behavior
vim.keymap.set({ "n", "x" }, "c", '"_c', { desc = "Change without Yanking" })
vim.keymap.set({ "n", "x" }, "C", '"_C', { desc = "Change without Yanking" })
vim.keymap.set({ "x" }, "p", "P", { desc = "Paste without Yanking" })
vim.keymap.set({ "x" }, "P", "p", { desc = "Yank then Paste" })

-- Folds
vim.keymap.set({ "n" }, "zj", "zm", { desc = "Fold More" })
vim.keymap.set({ "n" }, "zk", "zr", { desc = "Fold Less" })

-- Cmdline auto completion
vim.keymap.set({ "c" }, "<c-k>", function()
  return vim.fn.wildmenumode() == 1 and "<Left>" or "<Up>"
end, { desc = "Wildmenu Fix", expr = true, noremap = true })
vim.keymap.set({ "c" }, "<c-j>", function()
  return vim.fn.wildmenumode() == 1 and "<Right>" or "<Down>"
end, { desc = "Wildmenu Fix", expr = true, noremap = true })

-- Terminal
-- vim.keymap.set({ "n" }, "<c-cr>", function()
--   LazyVim.terminal()
-- end, { desc = "Toggle Terminal" })
vim.keymap.set({ "t" }, "<c-cr>", "<cmd>close<cr>", { desc = "Close Window" })

-- Jumplist
vim.keymap.set({ "n" }, "<c-[>", "<c-o>", { desc = "Jump Back" })
vim.keymap.set({ "n" }, "<c-]>", "<c-i>", { desc = "Jump Forward" })
