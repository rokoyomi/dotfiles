
vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    {
        src = "https://github.com/saghen/blink.cmp",
        branch = "v1",
    },
    {
        src = "https://github.com/L3MON4D3/LuaSnip",
    }
})

require('mason').setup{}

local mason_servers = {
    clangd = {},
    gopls = {},
    -- default lua_ls config
    lua_ls = {
        on_init = function(client)
            client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

            if client.workspace_folders then
                local path = client.workspace_folders[1].name
                if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
            end

            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                runtime = {
                    version = 'LuaJIT',
                    path = { 'lua/?.lua', 'lua/?/init.lua' },
                },
                workspace = {
                    checkThirdParty = false,
                    -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
                    --  See https://github.com/neovim/nvim-lspconfig/issues/3189
                    library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
                        '${3rd}/luv/library',
                        '${3rd}/busted/library',
                    }),
                },
            })
        end,
        ---@type lspconfig.settings.lua_ls
        settings = {
            Lua = {
                format = { enable = false }, -- Disable formatting (formatting is done by stylua)
            },
        },
    }
}

local ensure_installed = vim.tbl_keys(mason_servers or {})
require('mason-tool-installer').setup{ ensure_installed = ensure_installed }

for name, conf in pairs(mason_servers) do
    vim.lsp.config(name, conf)
    vim.lsp.enable(name)
end

local preinstalled_servers = { pyright = {}, bashls = {} }
for name, conf in pairs(preinstalled_servers) do
    vim.lsp.config(name, conf)
    vim.lsp.enable(name)
end

require('luasnip').setup{}

require('blink.cmp').setup{
    keymap = {
        preset = "default",

        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },

        ['<Tab>'] = { 'select_and_accept', 'fallback' },
        ['<C-k>'] = { 'show_signature', 'fallback' }
    },

    appearance = {
        nerd_font_variant = 'mono'
    },

    completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 250 }
    },

    sources = {
        default = { 'lsp', 'path', 'snippets' }
    },

    snippets = { preset = 'luasnip' },

    signature = { enabled = true }
}

vim.lsp.config["*"] = {
    capabilities = require('blink.cmp').get_lsp_capabilities()
}

