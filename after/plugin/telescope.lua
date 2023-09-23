local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>fa', builtin.find_files, {})
vim.keymap.set('n', '<leader>ff', builtin.git_files, {})
-- fu for "find usage"
vim.keymap.set("n", "<leader>fu", "<cmd>Telescope lsp_references<CR>")
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>")
