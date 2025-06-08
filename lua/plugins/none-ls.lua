return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.sqlfluff.with({
					extra_args = { "--dialect", "tsql" }, -- change to your dialect
				}),
				--null_ls.builtins.diagnostics.ktlint,
				--null_ls.builtins.formatting.ktlint,
				--null_ls.builtins.completion.spell,
				null_ls.builtins.diagnostics.sqlfluff.with({
					extra_args = { "--dialect", "tsql" }, -- change to your dialect
				}),
			},
		})
		vim.keymap.set({ "n", "v" }, "<leader>oc", vim.lsp.buf.format, {})
	end,
}
