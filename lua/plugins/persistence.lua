return {
  "folke/persistence.nvim",
  dependencies = {
    {
      "tiagovla/scope.nvim",
    },
  },
  opts = {
    pre_save = function()
      vim.cmd([[ScopeSaveState]]) -- Scope.nvim saving
    end,
    pre_load = function()
      vim.cmd([[ScopeLoadState]]) -- Scope.nvim loading
    end,
  },
}
