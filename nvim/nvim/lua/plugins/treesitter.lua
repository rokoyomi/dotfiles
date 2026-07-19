-- treesitter
vim.pack.add({{
    src    = "https://github.com/nvim-treesitter/nvim-treesitter",
    branch = "main",
    build  = ":TSUpdate",
}})

local parsers = { 'bash', 'c', 'cpp', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'go' }
require('nvim-treesitter').install(parsers)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

