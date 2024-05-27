local mason = require("mason")
local lsp_zero = require("lsp-zero")
local mason_lspconfig = require("mason-lspconfig")

mason.setup({
	ui = {
		icons = {
			package_installed = "",
			package_pending = "",
			package_uninstalled = "",
		},
	},
})
mason_lspconfig.setup({
	handlers = {
		lsp_zero.default_setup,
		lua_ls = function()
			local lua_opts = lsp_zero.nvim_lua_ls()
			require("lspconfig").lua_ls.setup(lua_opts)
		end,
	},
	ensure_installed = {
		"tsserver",
		"rust_analyzer",
		"html",
		"cssls",
		"tailwindcss",
		"lua_ls",
		"svelte",
		"prismals",
		"pyright",
		"graphql",
		"jdtls",
	},

	automatic_installation = true,
})
