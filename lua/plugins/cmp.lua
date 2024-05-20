local lspkind_icons = {
  Namespace = "󰌗",
  Text = "󰉿",
  Method = "󰆧",
  Function = "󰆧",
  Constructor = "",
  Field = "󰜢",
  Variable = "󰀫",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "󰑭",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈚",
  Reference = "󰈇",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "󰙅",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰊄",
  Table = "",
  Object = "󰅩",
  Tag = "",
  Array = "[]",
  Boolean = "",
  Number = "",
  Null = "󰟢",
  String = "󰉿",
  Calendar = "",
  Watch = "󰥔",
  Package = "",
  Copilot = "",
  Codeium = "",
  TabNine = "",
}

return {
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  {
    "onsails/lspkind.nvim",
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-buffer" },
      { "saadparwaiz1/cmp_luasnip" },
    },
    config = function()
      local cmp = require("cmp")
      local select_opts = { behavior = cmp.SelectBehavior.Select }
      local function border(hl_name)
        return {
          { "╭", hl_name },
          { "─", hl_name },
          { "╮", hl_name },
          { "│", hl_name },
          { "╯", hl_name },
          { "─", hl_name },
          { "╰", hl_name },
          { "│", hl_name },
        }
      end

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")

      cmp.setup({
        auto_brackets = {},
        completion = {
          completeopt = "menu,menuone",
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "nvim_lua" },
          { name = "path" },
        },
        window = {
          completion = {
            side_padding = 1,
            -- winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
            winhighlight = "Normal:CmpPmenu",
            scrollbar = false,
            border = border("CmpBorder"),
          },
          documentation = {
            border = border("CmpDocBorder"),
            winhighlight = "Normal:CmpDoc",
          },
        },
        ---@diagnostic disable-next-line: missing-fields
        formatting = {
          fields = { "abbr", "kind", "menu" },
          format = function(entry, item)
            local icon = lspkind_icons[item.kind] or ""
            icon = " " .. icon .. " "
            item.menu = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 60 })(entry, item)
                and "   (" .. item.kind .. ")"
              or ""
            item.kind = icon
            return item
          end,
        },
        -- See :help cmp-mapping
        mapping = {
          -- fire it up
          ["<c-space>"] = cmp.mapping.complete(),

          -- for the normies
          ["<Up>"] = cmp.mapping.select_prev_item(select_opts),
          ["<Down>"] = cmp.mapping.select_next_item(select_opts),

          -- for the hardos
          ["<C-k>"] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() then
                return cmp.select_prev_item(select_opts)
              end

              fallback()
            end,
          }),
          ["<C-j>"] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() then
                return cmp.select_next_item(select_opts)
              end
              fallback()
            end,
          }),

          -- scrolling docs
          ["<C-b>"] = cmp.mapping({
            c = function(fallback)
              if cmp.visible() then
                return cmp.scroll_docs(-4)
              end

              fallback()
            end,
          }),
          ["<C-f>"] = cmp.mapping({
            c = function(fallback)
              if cmp.visible() then
                return cmp.scroll_docs(4)
              end

              fallback()
            end,
          }),

          -- hide it if it's irritating
          ["<C-c>"] = cmp.mapping.abort(),
          ["<ESC>"] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() then
                return cmp.abort()
              end
              fallback()
            end,
          }),

          ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
              cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
      })
    end,
  },
}
