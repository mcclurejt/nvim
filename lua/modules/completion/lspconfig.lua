local M = {}

require('mason').setup({
  ui = {
    border = 'rounded',
  },
})

-- neodev must be before lspconfig
require('neodev').setup({})

local lspstatus = require('lsp-status')
lspstatus.register_progress()

local lspconfig = require('lspconfig')

M.capabilities = vim.tbl_deep_extend(
  'force',
  vim.lsp.protocol.make_client_capabilities(),
  require('cmp_nvim_lsp').default_capabilities(),
  lspstatus.capabilities
)

function M._attach(client, _)
  lspstatus.on_attach(client)
  -- vim.opt.omnifunc = 'v:lua.vim.lsp.omnifunc'
  -- client.server_capabilities.semanticTokensProvider = nil
  -- local original = vim.notify
  -- local mynotify = function(msg, level, opts)
  --   if msg == 'No code actions available' or msg:find('overly') then
  --     return
  --   end
  --   original(msg, level, opts)
  -- end
  -- vim.notify = mynotify
end

local servers = {
  'bashls', -- bash
  'bufls', -- protobuf
  'clangd', -- c/c++
  'codelldb', -- rust stuffs
  -- 'denols', -- deno
  'dockerls', -- docker
  -- 'eslint', -- ts/js linting
  'gopls', -- golang
  'jsonls', -- json
  -- 'biome', -- ts/js
  'jqls', -- jq
  'lua_ls', -- lua
  'marksman', -- markdown
  'prettierd', -- ts/js formatting
  'rust_analyzer', -- rust
  'spectral', -- openapi
  'jedi_language_server', -- python
  'shfmt', -- shell
  'sqlls', -- sql
  'solidity_ls_nomicfoundation',
  'solhint',
  'stylua', -- lua
  'taplo', -- toml
  'terraformls', -- terraform
  'tsserver', -- typescript
  'yamlls', -- yaml
  'zls', -- zig
}

vim.lsp.handlers['workspace/diagnostic/refresh'] = function(_, _, ctx)
  local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
  local bufnr = vim.api.nvim_get_current_buf()
  vim.diagnostic.reset(ns, bufnr)
  return true
end

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'single',
})
-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
--   border = "single",
--   focusable = false,
--   relative = "cursor",
-- })

-- require('mason-lspconfig').setup({
--   ensure_installed = servers,
--   handlers = {
--     ['rust_analyzer'] = function() end,
--     function(server)
--       if server == 'rust_analyzer' then
--         return
--       end
--       lspconfig[server].setup({
--         -- handlers = lspstatus.extensions[server].setup(),
--         on_attach = M._attach,
--         capabilities = M.capabilities,
--       })
--     end,
--   },
-- })

-- require('mason-tool-installer').setup({
--   ensure_installed = servers,
--   start_delay = 1000, -- 1 second delay
-- })

return M
