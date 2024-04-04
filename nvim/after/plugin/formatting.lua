--require('formatter.util').setup={
--}
require("mason").setup()

require("mason-nvim-lint").setup({
    ensure_installed = {'ast-grep','revive'},
})

require('lint').linters_by_ft = {
  markdown = {'ast-grep'},
  lua = {'selene'},
  html= {'ast-grep'},
  javascript= {'eslint_d','biome'},
  typescript= {'eslint_d','biome'},
  css= {'ast-grep'},
  javascriptreact= {'eslint_d','biome'},
  typescriptreact= {'eslint_d','biome'},
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
