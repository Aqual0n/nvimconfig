local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    -- Replace the language servers listed here 
    -- with the ones you want to install
    ensure_installed = { 'tsserver', 'eslint', 'vuels', 'tailwindcss', 'cssls', 'lua_ls' },
    handlers = {
        lsp_zero.default_setup,
        cssls = function ()
            require'lspconfig'.cssls.setup {
                settings = { 
                    css = { validate = true, lint = { unknownAtRules = "ignore" } },
                    less = { validate = true, lint = { unknownAtRules = "ignore" } },
                    scss = { validate = true, lint = { unknownAtRules = "ignore" } },
                },
            }
        end
    },
})

