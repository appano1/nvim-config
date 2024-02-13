return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = { "lua", "vim", "vimdoc", "html", "javascript", "typescript", "vue" },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
