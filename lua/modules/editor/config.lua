local config = {}

-- Treesitter
function config.nvim_treesitter()
  vim.api.nvim_command('set foldmethod=expr')
  vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
  ---@diagnostic disable-next-line: missing-fields
  require('nvim-treesitter.configs').setup({
    ensure_installed = 'all',
    auto_install = true,
    ignore_install = { 'phpdoc', 'scfg', 'smali' },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    -- textobjects = {
    --   move = {
    --     goto_next_start = { [']f'] = '@function.outer' },
    --     goto_next_end = { [']F'] = '@function.outer' },
    --     goto_previous_start = { ['[f'] = '@function.outer' },
    --     goto_previous_end = { ['[F'] = '@function.outer' },
    --   },
    -- },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<C-space>',
        node_incremental = '<C-space>',
        scope_incremental = false,
        node_decremental = '<bs>',
      },
    },
    ident = { enable = true },
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = nil,
    },
  })
end

return config
