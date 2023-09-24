vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<CR>")
vim.keymap.set("n", "<leader>ga", "<cmd>Git add .<CR>")
vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>")
-- this command is absolutely nuts
vim.keymap.set("n", "<leader>gd", "<cmd>Git difftool -y HEAD<CR>")
vim.keymap.set("n", "<leader>gm", "<cmd>Git push -u origin HEAD<CR>")
