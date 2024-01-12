local package = require('core.pack').package
local conf = require('modules.tools.config')

-- Which-Key
package({
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {},
})
