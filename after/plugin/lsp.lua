-- TODO: THIS FILE IS A MESS, WE WILL HAVE TO FIX IT
-- AT SOME POINT
--

-- hover border fix
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    vim.keymap.set('n', 'K', function()
      vim.lsp.buf.hover {
        border = 'rounded',
      }
    end, { buffer = event.buf })
  end,
})

-- error messages
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

local ensure_installed = {
    --lua
    'lua_ls',
    --ruby
    'rubocop',
    'ruby_lsp',
    --vue
    'vue_ls',
    'vtsls',
    --js
    --'ts_ls',
    'eslint',
    --css
    'tailwindcss',
    'cssls',
}

require('mason').setup()

require('mason-lspconfig').setup({
    ensure_installed = ensure_installed,
    automatic_enable = true,
    except = {
        'ts_ls'
    }
})

vim.lsp.config('lua_ls', {
    settings = {
        Lua = { diagnostics = { globals = { "vim" } } }
    }
})

vim.lsp.config('scssls', {
    settings = {
        css = { validate = true, lint = { unknownAtRules = "ignore" } },
        less = { validate = true, lint = { unknownAtRules = "ignore" } },
        scss = { validate = false, lint = { unknownAtRules = "ignore" } },
    },
})

vim.lsp.config('ruby_lsp', {
    cmd = { "bundle", "exec", "ruby-lsp" },
    filetypes = { 'ruby', 'eruby' },
    init_options = {
        formatter = 'auto'
    },
    root_markers = { 'Gemfile', '.git' }
})

vim.lsp.config('rubocop', {
    cmd = { "bundle", "exec", "rubocop" },
    filetypes = { 'ruby', 'eruby' },
    init_options = {
        formatter = 'auto'
    },
    root_markers = { 'Gemfile', '.git' }
})

vim.lsp.config('eslint', {
    on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll"
        })
    end
})

local vue_language_server_path = vim.fn.expand '$MASON/packages' ..
    '/vue-language-server' .. '/node_modules/@vue/language-server'
local vue_plugin = {
    name = '@vue/typescript-plugin',
    location = vue_language_server_path,
    languages = { 'vue' },
    configNamespace = 'typescript',
}

local vtsls_config = {
    settings = {
        vtsls = {
            tsserver = {
                globalPlugins = {
                    vue_plugin,
                },
            },
        },
    },
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
}

local vue_ls_config = {
    on_attach = function(client, bufnr)
        local timer = vim.loop.new_timer()

        -- Wait up to 1s for vtsls to attach
        local function wait_for_vtsls()
            local ts_clients = vim.lsp.get_clients({ name = "vtsls", bufnr = bufnr })
            if #ts_clients == 0 then
                return false
            end

            -- Now it's safe to register handler
            client.handlers["tsserver/request"] = function(_, result, context)
                local ts_client = ts_clients[1]

                local param = unpack(result)
                local id, command, payload = unpack(param)

                ts_client:exec_cmd({
                    title = "vue_request_forward",
                    command = "typescript.tsserverRequest",
                    arguments = { command, payload },
                }, { bufnr = context.bufnr }, function(_, r)
                    if not r or not r.body then
                        vim.notify("vtsls returned nil or empty body", vim.log.levels.WARN)
                        return
                    end
                    client:notify("tsserver/response", { { id, r.body } })
                end)
            end

            return true
        end

        -- Start polling for vtsls to be ready
        local tries = 0
        timer:start(100, 200, vim.schedule_wrap(function()
            tries = tries + 1
            if wait_for_vtsls() then
                vim.notify("vue_ls: forwarding tsserver requests via vtsls ✅", vim.log.levels.INFO)
                timer:stop()
                timer:close()
            elseif tries > 50 then
                vim.notify("vue_ls: vtsls did not attach in time 😢", vim.log.levels.ERROR)
                timer:stop()
                timer:close()
            end
        end))
    end
}
-- nvim 0.11 or above
vim.lsp.config('vtsls', vtsls_config)
vim.lsp.config('vue_ls', vue_ls_config)
vim.lsp.enable({ 'vtsls', 'vue_ls' })
