-- Buffers
return {
  {
    "tiagovla/scope.nvim",
    opts = {
      pre_tab_leave = function()
        vim.api.nvim_exec_autocmds("User", { pattern = "ScopeTabLeavePre" })
      end,
      post_tab_enter = function()
        vim.api.nvim_exec_autocmds("User", { pattern = "ScopeTabEnterPost" })
      end,
    },
  },
  {
    "axkirillov/hbac.nvim",
    event = "VeryLazy",
    opts = {
      autoclose = true,
      threshold = 10,
    },
  },
}
