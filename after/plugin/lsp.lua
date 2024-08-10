local lsp_zero = require('lsp-zero')
local lspconfig = require 'lspconfig'

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

local ensure_installed = {
    'tsserver',
    'eslint',
    'vuels',
    'volar',
    'tailwindcss',
    'cssls',
    'lua_ls',
    'rubocop',
    'solargraph'
}

require('mason').setup({})
require('mason-lspconfig').setup({
    -- Replace the language servers listed here
    -- with the ones you want to install
    ensure_installed = ensure_installed,
    handlers = {
        lsp_zero.default_setup,
        cssls = function()
            lspconfig.lua_ls.setup {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        }
                    }
                },
            }
            lspconfig.cssls.setup {
                settings = {
                    css = { validate = true, lint = { unknownAtRules = "ignore" } },
                    less = { validate = true, lint = { unknownAtRules = "ignore" } },
                    scss = { validate = false, lint = { unknownAtRules = "ignore" } },
                },
            }
        end
    },
})
