return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
	},
	keys = {
		"<leader>Du",
		"<leader>DU",
	},
	config = function()
		print("dap")
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()

		vim.keymap.set("n", "<leader>Du", function()
			dapui.toggle({ layout = 2 })
		end, {
			desc = "Toggle Simple Debug ui, I mainly use it to run tests",
		})

		vim.keymap.set("n", "<leader>DU", function()
			dapui.toggle()
		end, {
			desc = "Toggle Full Debug ui",
		})

		-- Add dap configurations based on your language/adapter settings
		-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
		dap.configurations.java = {
			{
				name = "Debug Launch (2GB)",
				type = "java",
				request = "launch",
				vmArgs = "" .. "-Xmx2g ",
			},
			{
				name = "Debug Attach (8000)",
				type = "java",
				request = "attach",
				hostName = "127.0.0.1",
				port = 8000,
			},
			{
				name = "Debug Attach (5005)",
				type = "java",
				request = "attach",
				hostName = "127.0.0.1",
				port = 5005,
			},
			{
				name = "My Custom Java Run Configuration",
				type = "java",
				request = "launch",
				-- You need to extend the classPath to list your dependencies.
				-- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
				-- classPaths = {},

				-- If using multi-module projects, remove otherwise.
				-- projectName = "yourProjectName",

				-- javaExec = "java",
				mainClass = "replace.with.your.fully.qualified.MainClass",

				-- If using the JDK9+ module system, this needs to be extended
				-- `nvim-jdtls` would automatically populate this property
				-- modulePaths = {},
				vmArgs = "" .. "-Xmx2g ",
			},
		}
	end,
}
