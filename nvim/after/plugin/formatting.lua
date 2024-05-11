require("mason").setup()

require("mason-nvim-lint").setup({
	ensure_installed = { "eslint_d", "prettierd", "prettier", "stylua" },
})

require("lint").linters_by_ft = {
	lua = { "selene" },
	typescript = { "eslint_d" },
	javascript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescriptreact = { "eslint_d" },
	markdown = { "cbfmt" },
	--	java = { "checkstyle" },
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
	},
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = "*",
	callback = function(args)
		require("lint").try_lint()
		require("conform").format({ bufnr = args.buf })
	end,
})
