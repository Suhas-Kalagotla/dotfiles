vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.g.mapleader = " "

---- Enable automatic reloading
vim.opt.autoread = true
--
---- Notify the user when a file is reloaded
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "CursorHold" }, {
	command = "checktime",
})
--
---- Inform the user when the file is reloaded
vim.api.nvim_create_autocmd("FileChangedShellPost", {
	command = 'echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None',
})
