local ls = require("luasnip")
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
