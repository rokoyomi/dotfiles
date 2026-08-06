
vim.pack.add{
    "https://github.com/catgoose/nvim-colorizer.lua"
}

require("colorizer").setup({
    options = { parsers = { css = true } },
})

-- require("colorizer").setup{
--     "*";
--     css = { rgb_fn = true; };
-- }

