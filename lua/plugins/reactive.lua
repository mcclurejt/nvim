return {
  'rasulomaroff/reactive.nvim',
  dependencies = {
    'catppuccin/nvim',
  },
  config = function()
    require('reactive').setup({
      load = 'catppuccin-mocha-cursor',
    })
  end,
}
