return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettierd,
      },
    })

    vim.keymap.set({ "n", "i" }, "<M-F>", function()
      vim.lsp.buf.format({
        filter = function(client)
          return client.name ~= "tsserver" and client.name ~= "volar"
        end,
      })
    end, {})
  end,
}
