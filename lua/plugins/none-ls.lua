return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				--null_ls.builtins.diagnostics.ktlint,
				--null_ls.builtins.formatting.ktlint,
				--null_ls.builtins.completion.spell,
			},
		})
		vim.keymap.set("n", "<leader>oc", vim.lsp.buf.format, {})
	end,
}
