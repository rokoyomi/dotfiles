-- options
vim.opt.number = true

vim.opt.expandtab   = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth  = 4

vim.opt.relativenumber = true
vim.o.cursorline = true

-- keymaps
vim.g.mapleader = " "
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set("n", "\\", ":Lex 20<CR>", { desc = "Toggle File Explorer" })
vim.keymap.set("n", "<leader>w", "<C-w>")

vim.keymap.set("v", "<", "<gv", { desc = "Indent left, reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right, reselect" })
vim.keymap.set("v", "=", "=gv", { desc = "Auto indent, reselect" })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open Floating Diagnostic Window" })

vim.diagnostic.config{
    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = { min = vim.diagnostic.severity.WARN } },

    virtual_text = true,
    virtual_lines = false,
}

require('plugins')
require('lsp')

