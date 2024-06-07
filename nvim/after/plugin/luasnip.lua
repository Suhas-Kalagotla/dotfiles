local ls = require("luasnip")

ls.config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
	enable_autosnippets = true,
})

require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/dotfiles/nvim/after/snippets" })

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
	require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/dotfiles/nvim/after/snippets" })
	require("luasnip.loaders.from_lua").lazy_load({ paths = "~/dotfiles/nvim/after/snippets/snips" })
end

vim.keymap.set("n", ",r", M.refresh_snippets)

local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

ls.add_snippets("lua", {
	snip(
		"some",
		choice(1, {
			text("1st"),
			text("2st"),
			text("this is something else"),
		})
	),
})

ls.add_snippets("java", {
	snip("sys", {
		text("System.out.println("),
		insert(1),
		text(");"),
	}),
})

ls.add_snippets("java", {
	snip("pairc", {
		text({
			"static class Pair implements Comparable<Pair> {",
			"    int x, y;",
			"",
			"    Pair(int x, int y) {",
			"      this.x = x;",
			"      this.y = y;",
			"    }",
			"",
			"    public int compareTo(Pair p) {",
			"      return ",
		}),
		choice(1, {
			text("this.x - p.x; // ascending order by x"),
			text("p.x - this.x; // decending order by x"),
			text("this.y - p.y; // ascending order by y"),
			text("p.y - this.y; // descending order by y"),
		}),
		text({
			"",
			"    }",
			"  }",
		}),
	}),
})
