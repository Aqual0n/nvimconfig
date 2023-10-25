local lsp_zero = require('lsp-zero')
local lspconfig = require'lspconfig'

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    -- Replace the language servers listed here 
    -- with the ones you want to install
    ensure_installed = { 'tsserver', 'eslint', 'vuels', 'volar', 'tailwindcss', 'cssls', 'lua_ls' },
    handlers = {
        lsp_zero.default_setup,
        cssls = function ()
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
            lspconfig.eslint.setup({
                flags = { debounce_text_changes = 500 },
                on_attach = function()
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' },
                        command = 'silent! EslintFixAll',
                        group = vim.api.nvim_create_augroup('MyAutocmdsJavaScripFormatting', {}),
                    })
                end,
            })
        end
    },
})
