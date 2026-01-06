return {
	{
		"mason-org/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		lazy = false,
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"bashls",
					"lua_ls",
					"jdtls",
					"jsonls",
					"lemminx", --xml
					"html",
					"dockerls",
					"marksman", --markdown
					--"kotlin_language_server",
					"clangd",
					"gopls",
				},
				automatic_enable = {
					exclude = {
						"jdtls",
						"lua_ls",
						"clangd",
						"lemminx",
						"gopls",
					},
				},
			})
		end,
	},
	{ "j-hui/fidget.nvim", opts = {} },
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({
				-- Install these linters, formatters, debuggers automatically
				ensure_installed = {
					"stylua",
					"sqlfluff",
					"java-debug-adapter",
					"java-test",
					-- "kotlin-debug-adapter",
					-- "ktlint",
					"clang-format",
                    "gofumpt",
                    -- "goimports_reviser",
                    "golines",
                    "delve", -- go debugger
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "saghen/blink.cmp" },
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		lazy = false,
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local builtin = require("telescope.builtin")

			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			vim.lsp.config("lemminx", {
				settings = {
					xml = {
						server = {
							workDir = vim.fn.expand("~/.cache/lemminx"),
						},
					},
				},
			})

            vim.lsp.config("gopls", {
                filetypes = { "go", "gomod", "gowork", "gotmpl" },
                settings = {
                    env = {
                        GOEXPERIMENT = "rangefunc",
                    },
                    formatting = {
                        gofumpt = true,
                    },
                },
            })

			vim.lsp.enable({ "lua_ls", "lemminx", "clangd", "gopls" })

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Jump to the definition of the word under your cursor.
					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-t>.
					map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					map("gr", builtin.lsp_references, "[G]oto [R]eferences")
					map("gi", builtin.lsp_implementations, "[G]oto [I]mplementation")
					map("<leader>D", builtin.lsp_type_definitions, "Type [D]efinition")
					map("<leader>s", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
					map("<leader>S", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>a", vim.lsp.buf.code_action, "[C]ode [A]ction")
					map("<leader>k", vim.lsp.buf.hover, "Hover Documentation")
					map("<C-s>", vim.lsp.buf.signature_help, "Help with signature")

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- The following autocommand is used to enable inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})
		end,
	},
}
