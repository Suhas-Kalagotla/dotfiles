function ColorMyPencils(color)
	vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

	require("catppuccin").setup()
	vim.cmd([[colorscheme catppuccin]])
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
