return {
  -- LSP client configs
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- Completion
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      -- Snippets (minimal)
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      -- cmp setup (minimal)
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
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
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
        },
      })

      -- Common LSP capabilities (for completion)
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Keep capabilities available for language configs
      vim.g._lsp_capabilities = capabilities

      -- Minimal diagnostics UI
      vim.diagnostic.config({
        virtual_text = true,
        severity_sort = true,
        float = { border = "rounded" },
      })
    end,
  },

  -- Treesitter (syntax highlight)
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      -- main rewrite API
      require("nvim-treesitter").setup({
        -- Install parsers you care about
        ensure_installed = {
          "lua", "vim", "vimdoc",
          "bash", "json", "toml", "yaml",
          "go", "rust", "haskell",
        },

        -- Parser install behavior
        auto_install = true,
      })

      -- Enable highlighting via Neovim built-in treesitter
      -- Apply to current and future buffers
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        callback = function(args)
          -- start treesitter for this buffer (safe if already started)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },
}

