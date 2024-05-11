-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use({
		"nvim-telescope/telescope.nvim",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	})

	use({
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			vim.cmd("colorscheme catppuccin")
		end,
	})
use("kien/ctrlp.vim"); 
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	use("ThePrimeagen/harpoon")
	use("nvim-treesitter/playground")
	use("mbbill/undotree")
	use("tpope/vim-fugitive")
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		requires = {
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			{ "neovim/nvim-lspconfig" },
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "L3MON4D3/LuaSnip" },
		},
		config = function()
			require("lsp-zero").extend_lspconfig()
		end,
	})
	use({
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!:).
		run = "make install_jsregexp",
	})
	use("vim-airline/vim-airline", { run = ":TSUpdate" })
	use("vim-airline/vim-airline-themes", { run = ":TSUpdate" })
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup()
		end,
	})
	use({
		"williamboman/mason.nvim",
		"mfussenegger/nvim-lint",
		"rshkarin/mason-nvim-lint",
	})
	use("stevearc/dressing.nvim")
	use("mhartington/formatter.nvim")
	use("stevearc/conform.nvim")
	use("bling/vim-bufferline", { run = ":TSUpdate" })
	use("christoomey/vim-tmux-navigator")
	use("nvim-tree/nvim-web-devicons")
end)
