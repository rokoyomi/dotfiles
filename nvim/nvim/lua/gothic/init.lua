-- lua/gothic/init.lua

local c = require("gothic.colors").palette

vim.cmd("highlight clear")
vim.o.termguicolors = true
vim.g.colors_name = "gothic"

local set = vim.api.nvim_set_hl

set(0, "Normal", {
    fg = c.text,
    bg = c.surface,
})

set(0, "Comment", {
    fg = c.gray,
    italic = true,
})

set(0, "String", {
    fg = c.tertiary,
})

set(0, "Keyword", {
    fg = c.primary,
    bold = true,
})

set(0, "Type", {
    fg = c.primary,
})

set(0, "Function", {
    fg = c.secondary,
})

set(0, "CursorLine", {
    bg = c.surface_alt,
})

