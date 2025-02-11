-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.colorcolumn = "80"
vim.opt.scrolloff = 999

-- folds
-- vim.g.lazyvim_statuscolumn.folds_open = true
-- vim.g.lazyvim_statuscolumn.folds_githl = true
vim.opt.sol = true
vim.opt.showtabline = 2

-- better python parser
vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.lazyvim_python_ruff = "ruff_lsp"

-- no spell checking
vim.opt.spell = false

-- always tabs
vim.opt.laststatus = 3

-- no hscroll w/ trackpad
vim.opt.mousescroll = "ver:1,hor:0"
vim.opt.wrap = true

-- no relative number
vim.opt.relativenumber = false

-- diagnostics
local sign = function(opts)
  -- See :help sign_define()
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = "",
  })
end

sign({ name = "DiagnosticSignError", text = "" })
sign({ name = "DiagnosticSignWarn", text = "" })
sign({ name = "DiagnosticSignInfo", text = "" })
sign({ name = "DiagnosticSignHint", text = "" })

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    border = "rounded",
    ---@diagnostic disable-next-line: assign-type-mismatch
    source = "always",
  },
})

vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- vim.opt.signcolumn = "no"
-- vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
