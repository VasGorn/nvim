local home_path = os.getenv("HOME")
local workspace_path = home_path .. "/.local/share/nvim/jdtls-workspace/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = workspace_path .. project_name

local status, jdtls = pcall(require, "jdtls")
if not status then
	return
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- Needed for debugging
local bundles = {
	vim.fn.glob(
		home_path .. "/.config/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar"
	),
}

-- Needed for running/debugging unit tests
vim.list_extend(
	bundles,
	vim.split(vim.fn.glob(home_path .. "/.config/.local/share/nvim/mason/share/java-test/*.jar", 1), "\n")
)

local config = {}

config.cmd = {
	"java",
	"-Declipse.application=org.eclipse.jdt.ls.core.id1",
	"-Dosgi.bundles.defaultStartLevel=4",
	"-Declipse.product=org.eclipse.jdt.ls.core.product",
	"-Dlog.protocol=true",
	"-Dlog.level=ALL",
	"-Xmx500m",

	--[[
        "-XX:+UseParallelGC",
        "-XX:GCTimeRatio=4",
        "-XX:AdaptiveSizePolicyWeight=90",
        "-Dsun.zip.disableMemoryMapping=true",
        "-Xmx1500m",
        "-Xms700m",
        "-Xlog:disable",
        ]]

	"--add-modules=ALL-SYSTEM",
	"--add-opens",
	"java.base/java.util=ALL-UNNAMED",
	"--add-opens",
	"java.base/java.lang=ALL-UNNAMED",
	"-javaagent:" .. home_path .. "/.config/.local/share/nvim/mason/packages/jdtls/lombok.jar",
	"-jar",
	vim.fn.glob(
		home_path .. "/.config/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"
	),
	"-configuration",
	home_path .. "/.config/.local/share/nvim/mason/packages/jdtls/config_linux",
	"-data",
	workspace_dir,
}

config.root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })

config.settings = {
	java = {
		home = home_path .. "/.sdkman/candidates/java/current",
		redhat = {
			telemetry = { enabled = true },
		},
		sources = {
			organizeImports = {
				starThreshold = 9999,
				staticStarThreshold = 9999,
			},
		},
		signatureHelp = { enabled = true },
		extendedClientCapabilities = extendedClientCapabilities,
		maven = { downloadSources = true },
		eclipse = { downloadSources = true },
		referencesCodeLens = { enabled = true },
		references = { includeDecompiledSources = true },
		-- Setup automatical package import oranization on file save
		saveActions = {
			organizeImports = false,
		},
		-- Use the fernflower decompiler when using the javap command to decompile byte code back to java code
		contentProvider = {
			preferred = "fernflower",
		},
		inlayHints = {
			parameterNames = {
				enabled = "all", -- literals, all, none
			},
		},
		codeGeneration = {
			toString = {
				template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
			},
			hashCodeEquals = {
				useJava7Objects = true,
			},
			useBlocks = true,
		},
		compile = {
			nullAnalysis = {
				nonnull = {
					"lombok.NonNull",
					"javax.annotation.Nonnull",
					"org.eclipse.jdt.annotation.NonNull",
					"org.springframework.lang.NonNull",
				},
			},
		},
		completion = {
			-- doesn't seem to work now with cmp.
			chain = { enabled = false },
			guessMethodArguments = "off",
			favouriteStaticMembers = {
				"org.junit.jupiter.api.Assertions.*",
				"org.junit.jupiter.api.Assumptions.*",
				"org.mockito.Mockito.*",
				"java.util.Objects.*",
			},
		},
		configuration = {
			runtimes = {
				{
					name = "JavaSE-11",
					path = home_path .. "/.sdkman/candidates/java/11.0.24-tem",
				},
				{
					name = "JavaSE-17",
					path = home_path .. "/.sdkman/candidates/java/17.0.12-tem",
				},
				{
					name = "JavaSE-21",
					path = home_path .. "/.sdkman/candidates/java/21.0.4-tem",
				},
			},
		},
		format = {
			settings = {
				url = home_path .. "/.config/nvim/eclipse-java-google-style.xml",
				profile = "GoogleStyle",
			},
		},
	},
}

config.init_options = {
	-- References the bundles defined above to support Debugging and Unit Testing
	bundles = bundles,
	extendedClientCapabilities = extendedClientCapabilities,
}

config.on_attach = function(client, bufnr)
	vim.keymap.set("n", "<leader>oi", function()
		jdtls.organize_imports()
	end, {
		desc = "organize imports",
	})
	vim.keymap.set("n", "<leader>oa", function()
		jdtls.organize_imports()
		vim.lsp.buf.format()
	end, {
		desc = "organize all",
	})

	vim.keymap.set("v", "<leader>jev", function()
		jdtls.extract_variable(true)
	end, {
		desc = "java extract selected to variable",
		noremap = true,
	})
	vim.keymap.set("n", "<leader>jev", function()
		jdtls.extract_variable()
	end, {
		desc = "java extract variable",
		noremap = true,
	})

	vim.keymap.set("v", "<leader>jeV", function()
		jdtls.extract_variable_all(true)
	end, {
		desc = "java extract all selected to variable",
		noremap = true,
	})
	vim.keymap.set("n", "<leader>jeV", function()
		jdtls.extract_variable_all()
	end, {
		desc = "java extract all to variable",
		noremap = true,
	})

	vim.keymap.set("n", "<leader>jec", function()
		jdtls.extract_constant()
	end, {
		desc = "java extract constant",
		noremap = true,
	})
	vim.keymap.set("v", "<leader>jec", function()
		jdtls.extract_constant(true)
	end, {
		desc = "java extract selected to constant",
		noremap = true,
	})

	vim.keymap.set("n", "<leader><leader>jem", function()
		jdtls.extract_method()
	end, {
		desc = "java extract method",
		noremap = true,
	})
	vim.keymap.set("v", "<leader>jem", function()
		jdtls.extract_method(true)
	end, {
		desc = "java extract selected to method",
		noremap = true,
	})
	vim.keymap.set("n", "<leader>joT", function()
		local plugin = require("jdtls.tests")
		plugin.goto_subjects()
	end, {
		desc = "java open test",
		noremap = true,
	})
	vim.keymap.set("n", "<leader>jct", function()
		local plugin = require("jdtls.tests")
		plugin.generate()
	end, {
		desc = "java create test",
		noremap = true,
	})

	vim.keymap.set("n", "<leader>jdm", function()
		jdtls.test_nearest_method()
	end, { desc = "java debug nearest test method" })

	vim.keymap.set("n", "<leader>jdc", function()
		jdtls.test_class()
	end, { desc = "java debug nearest test class" })

	vim.keymap.set("n", "<leader>jr", "<cmd>JdtWipeDataAndRestart<CR>", { desc = "restart jdtls" })

	-- Needed for debugging
	jdtls.setup_dap({ hotcodereplace = "auto" })
	require("jdtls.dap").setup_dap_main_class_configs()
end

-- Tell our JDTLS language features it is capable of
local capabilities = {
	workspace = {
		configuration = true,
	},
	textDocument = {
		completion = {
			snippetSupport = false,
		},
	},
}
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
for k, v in pairs(lsp_capabilities) do
	capabilities[k] = v
end
config.capabilities = capabilities

require("jdtls").start_or_attach(config)
