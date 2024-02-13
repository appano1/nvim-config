return {
	"smoka7/hop.nvim",
	config = function()
		local hop = require("hop")

		hop.setup({})

		vim.keymap.set({ "n", "v" }, "<leader><leader>", hop.hint_words)
	end,
}
