local ls = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/dotfiles/nvim/after/snippets" })
require("luasnip.loaders.from_lua").lazy_load({ paths = "~/dotfiles/nvim/after/snippets/snips" })

ls.config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
	enable_autosnippets = true,
})

vim.keymap.set({ "i" }, "<C-k>", function()
	ls.expand()
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-l>", function()
	ls.jump(1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-j>", function()
	ls.jump(-1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-h>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })

local M = {}
function M.refresh_snippets()
	ls.cleanup()
	M.reload_package("after.snippets.snips")
end

vim.keymap.set("n", ",r", M.refresh_snippets)
