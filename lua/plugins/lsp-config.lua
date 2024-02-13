return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "tsserver", "eslint", "volar", "jsonls" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "folke/neoconf.nvim",
    },
    config = function()
      require("neoconf").setup({})

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          local server_config = {
            capabilities = capabilities,
          }

          if require("neoconf").get(server_name .. ".disable") then
            return
          end

          if server_name == "lua_ls" then
            server_config.settings = {
              Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = {
                  globals = { "vim" },
                  disable = { "missing-parameters", "missing-fields" },
                },
                workspace = {
                  library = { vim.env.VIMRUNTIME },
                },
              },
            }
          elseif server_name == "volar" then
            server_config.filetypes = { "vue", "typescript", "javascript" }
          end

          lspconfig[server_name].setup(server_config)
        end,
      })

      vim.keymap.set("n", "gh", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
      vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, {})
      vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
    end,
  },
}
