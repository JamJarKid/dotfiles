vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>chr", '<cmd>!open -a "Google Chrome" %<CR>')
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "<leader>o", "o<Esc>", { silent = true, desc = "Insert new line below and exit" })
vim.keymap.set("n", "<leader>O", "O<Esc>", { silent = true, desc = "Insert new line above and exit" })
vim.keymap.set("n", "<leader>sv", "<C-w>v")
vim.keymap.set("n", "<leader>sh", "<C-w>s")
vim.keymap.set("n", "<leader>sx", ":close<CR>")

vim.keymap.set("n", "<leader>y", "+y")
vim.keymap.set("v", "<leader>y", "+y")
vim.keymap.set("n", "<leader>Y", "+Y")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

