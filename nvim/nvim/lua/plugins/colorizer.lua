
vim.pack.add{
    "https://github.com/norcalli/nvim-colorizer.lua"
}

require("colorizer").setup{
    "*";
    css = { rgb_fn = true; };
}

