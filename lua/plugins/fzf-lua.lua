return {
  "ibhagwan/fzf-lua",
  enabled = false,
  keys = {
    -- { "<leader><space>", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
    { "<leader>*", "<cmd>FzfLua grep_cword<cr>", desc = "Command History" },
    { "<leader>gc", false },
  },
  opts = {
    files = {
      git_icons = false,
    },
  },
}
