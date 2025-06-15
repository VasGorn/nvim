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
				"markdown_inline",
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
			auto_install = false,
			sync_install = false,
			highlight = {
				enable = true,

				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,

				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
			ignore_install = {},
			modules = {},
			additional_vim_regex_highlighting = false,
			-- enable tsx auto closing tag creation
			autotag = {
				enable = true,
			},
		})
	end,
}
