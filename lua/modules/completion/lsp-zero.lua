local lsp_zero = require('lsp-zero')
local navic = require('nvim-navic')
lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({ buffer = bufnr })
  navic.attach(client, bufnr)
end)

-- lsp_zero.format_on_save({
--   format_opts = {
--     async = false,
--     timeout_ms = 10000,
--   },
--   -- servers = {
--   --   ['tsserver'] = { 'javascript', 'typescript' },
--   --   ['rust_analyzer'] = { 'rust' },
--   -- },
-- })

lsp_zero.set_server_config({
  capabilities = {
    textDocument = {
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
  },
})
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
-- to learn how to use mason.nvim
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'tsserver', 'rust_analyzer', 'solidity_ls_nomicfoundation' },
  handlers = {
    lsp_zero.default_setup,
    -- function(server_name)
    --   require('lspconfig')[server_name].setup({ capabilities = capabilities })
    -- end,
    -- lua_ls = function()
    --   local lua_opts = lsp_zero.nvim_lua_ls()
    --   require('lspconfig').lua_ls.setup(lua_opts)
    -- end,
  },
})
