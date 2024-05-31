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
    "onsails/lspkind.nvim",
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-buffer" },
      { "lukas-reineke/cmp-rg" },
      { "hrsh7th/cmp-cmdline" },
      {
        "garymjr/nvim-snippets",
        opts = {
          friendly_snippets = true,
          global_snippets = { "all", "global" },
        },
        dependencies = { "rafamadriz/friendly-snippets" },
      },
    },
    config = function()
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
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

      local opts = {
        auto_brackets = {},
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "nvim_lua" },
          { name = "rg" },
          { name = "snippets" },
        }, {
          { name = "buffer" },
        }),
        window = {
          completion = {
            side_padding = 1,
            -- winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
            winhighlight = "Normal:CmpPmenu,Search:None",
            col_offset = -3,
            -- winhighlight = "Normal:CmpPmenu",
            scrollbar = false,
            border = border("CmpBorder"),
          },
          documentation = {
            border = border("CmpDocBorder"),
            winhighlight = "Normal:CmpDoc",
          },
        },
        snippet = {
          expand = function(item)
            return LazyVim.cmp.expand(item.body)
          end,
        },
        ---@diagnostic disable-next-line: missing-fields
        -- formatting = {
        --   fields = { "abbr", "kind", "menu" },
        --   format = function(entry, item)
        --     local icon = lspkind_icons[item.kind] or ""
        --     icon = " " .. icon .. " "
        --     item.menu = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 60 })(entry, item)
        --         and "   (" .. item.kind .. ")"
        --       or ""
        --     item.kind = icon
        --     return item
        --   end,
        -- },
        ---@diagnostic disable-next-line: missing-fields
        formatting = {
          format = function(_, item)
            local icons = require("lazyvim.config").icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = defaults.sorting,
        -- See :help cmp-mapping
        mapping = {
          -- fire it up
          ["<c-space>"] = cmp.mapping.complete(),
          -- for the normies
          ["<Up>"] = cmp.mapping.select_prev_item(select_opts),
          ["<Down>"] = cmp.mapping.select_next_item(select_opts),
          -- for the hardos
          ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          -- scrolling docs
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
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
          ["<CR>"] = LazyVim.cmp.confirm(),
          ["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
              cmp.confirm({ select = true })
            elseif vim.snippet.active({ direction = 1 }) then
              vim.schedule(function()
                vim.snippet.jump(1)
              end)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif vim.snippet.active({ direction = -1 }) then
              vim.schedule(function()
                vim.snippet.jump(-1)
              end)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
      }

      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end

      local parse = require("cmp.utils.snippet").parse
      ---@diagnostic disable-next-line: duplicate-set-field
      require("cmp.utils.snippet").parse = function(input)
        local ok, ret = pcall(parse, input)
        if ok then
          return ret
        end
        return LazyVim.cmp.snippet_preview(input)
      end

      cmp.setup(opts)
      cmp.event:on("confirm_done", function(event)
        if vim.tbl_contains(opts.auto_brackets or {}, vim.bo.filetype) then
          LazyVim.cmp.auto_brackets(event.entry)
        end
      end)
      cmp.event:on("menu_opened", function(event)
        LazyVim.cmp.add_missing_snippet_docs(event.window)
      end)
      return opts
    end,
  },
}
