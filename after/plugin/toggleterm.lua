--vim.keymap.set("n", "<C-\\>", "<cmd>ToggleTerm direction=horizontal<CR>")

require("toggleterm").setup {
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    close_on_exit = false,
    direction = "horizontal",
}

function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
    vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
    vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
    vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
