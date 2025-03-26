return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		-- ts-autotag utilizes treesitter to understand the code structure to automatically close tsx tags
		"windwp/nvim-ts-autotag",
	},
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"scheme",
				"query",
				"javascript",
				"html",
				"markdown",
				"mermaid",
				"java",
				"bash",
				"go",
				"json",
				-- "kotlin",
				"latex",
				"regex",
				"sql",
				"toml",
				"yaml",
				"xml",
				"tmux",
				"jq",
				"groovy",
				"asm",
				"cmake",
				"make",
				"properties",
				"dockerfile",
				"diff",
				"csv",
			},
			auto_install = true,
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			-- enable tsx auto closing tag creation
			autotag = {
				enable = true,
			},
		})
	end,
}
