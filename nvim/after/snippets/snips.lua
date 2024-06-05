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
	print("lua snips loaded"),
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
	print("java snips loaded"),
})
