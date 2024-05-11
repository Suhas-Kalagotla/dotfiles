local lsp_zero = require("lsp-zero")
local keymap = vim.keymap

lsp_zero.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	opts.buffer = bufnr

	opts.desc = "Show LSP references"
	keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

	opts.desc = "Go to declaration"
	keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

	opts.desc = "Show LSP definitions"
	keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

	opts.desc = "Show LSP implementations"
	keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

	opts.desc = "Show LSP type definitions"
	keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

	opts.desc = "See available code actions"
	keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

	opts.desc = "Smart rename"
	keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

	opts.desc = "Show buffer diagnostics"
	keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

	opts.desc = "Show line diagnostics"
	keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

	opts.desc = "Go to previous diagnostic"
	keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

	opts.desc = "Go to next diagnostic"
	keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

	opts.desc = "Show documentation for what is under cursor"
	keymap.set("n", "K", vim.lsp.buf.hover, opts)

	opts.desc = "Restart LSP"
	keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
end)

-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = { "tsserver", "rust_analyzer" },
	handlers = {
		lsp_zero.default_setup,
		lua_ls = function()
			local lua_opts = lsp_zero.nvim_lua_ls()
			require("lspconfig").lua_ls.setup(lua_opts)
		end,
	},
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

-- this is the function that loads the extra snippets to luasnip
-- from rafamadriz/friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()
cmp.setup({
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip", keyword_length = 2 },
		{ name = "buffer", keyword_length = 3 },
	},
	formatting = lsp_zero.cmp_format({ details = false }),
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
})
