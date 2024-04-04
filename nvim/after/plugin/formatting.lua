require("mason").setup()

require("mason-nvim-lint").setup({
	ensure_installed = { "ast-grep", "revive" },
})

require("lint").linters_by_ft = {
	markdown = { "ast-grep" },
	lua = { "selene" },
	html = { "ast-grep" },
	typescript = { "oxlint" },
	javascript = { "oxlint" },
	css = { "ast-grep" },
	javascriptreact = { "oxlint" },
	typescriptreact = { "oxlint" },
}

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		javascript = { { "prettierd", "prettier" } },
		typescript = { { "prettierd", "prettier" } },
		typescriptreact = { { "prettierd", "prettier" } },
		javascriptreact = { { "prettierd", "prettier" } },
	},
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = "*",
	callback = function(args)
		require("lint").try_lint()
		require("conform").format({ bufnr = args.buf })
	end,
})
