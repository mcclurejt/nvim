return {
  "andythigpen/nvim-coverage",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    commands = true, -- create commands,
    signs = {
      -- use your own highlight groups or text markers
      covered = { hl = "CoverageCovered", text = "" },
      uncovered = { hl = "CoverageUncovered", text = "" },
    },
  },
}
