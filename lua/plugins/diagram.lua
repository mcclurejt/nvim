return {
  "3rd/diagram.nvim",
  enabled = false,
  dependencies = {
    { "3rd/image.nvim", build = false, opts = { processor = "magick_cli" } },
  },
  opts = { -- you can just pass {}, defaults below
    renderer_options = {
      mermaid = {
        background = nil, -- nil | "transparent" | "white" | "#hex"
        theme = nil, -- nil | "default" | "dark" | "forest" | "neutral"
        scale = 1, -- nil | 1 (default) | 2  | 3 | ...
      },
      plantuml = {
        charset = nil,
      },
      d2 = {
        theme_id = nil,
        dark_theme_id = nil,
        scale = nil,
        layout = nil,
        sketch = nil,
      },
    },
  },
  config = function()
    require("diagram").setup({
      integrations = {
        require("diagram.integrations.markdown"),
        require("diagram.integrations.neorg"),
      },
      renderer_options = {
        mermaid = {
          theme = "forest",
        },
        plantuml = {
          charset = "utf-8",
        },
        d2 = {
          theme_id = 1,
        },
      },
    })
  end,
}
