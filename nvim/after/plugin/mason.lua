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
		"jsonls",
	},

	automatic_installation = true,
})

require("mason-nvim-lint").setup({
	ensure_installed = { "checkstyle", "jsonlint", "selene", "eslint_d", "prettierd", "prettier", "stylua" },
	automatic_installation = true,
})

require("lint").linters_by_ft = {
	lua = { "selene" },
	typescript = { "eslint_d" },
	javascript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescriptreact = { "eslint_d" },
	json = { "jsonlint" },
}

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort" },
		javascript = { { "prettierd", "prettier" } },
		typescript = { "prettierd", "prettier" },
		typescriptreact = { { "prettierd", "prettier" } },
		javascriptreact = { { "prettierd", "prettier" } },
		java = { "google-java-format" },
		css = { "prettier" },
		markdown = { "cbfmt" },
		json = { "fixjson" },
		cpp = { "cpplint" },
	},
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = "*",
	callback = function(args)
		require("lint").try_lint()
		require("conform").format({ bufnr = args.buf })
	end,
})
