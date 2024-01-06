local remap = vim.keymap.set
vim.g.mapleader = " "

remap("n", "<leader>pv", vim.cmd.Ex)
remap("n", "<leader>chr", '<cmd>!open -a "Google Chrome" %<CR>')
remap("n", "x", '"_x')
remap("n", "<leader>o", "o<Esc>", { silent = true, desc = "Insert new line below and exit" })
remap("n", "<leader>O", "O<Esc>", { silent = true, desc = "Insert new line above and exit" })
remap("n", "<leader>sv", "<C-w>v")
remap("n", "<leader>sh", "<C-w>s")
remap("n", "<leader>sx", ":close<CR>")

remap("n", "<leader>y", "\"+y")
remap("v", "<leader>y", "\"+y")
remap("n", "<leader>Y", "\"+Y")

remap("n", "<C-d>", "<C-d>zz")
remap("n", "<C-u>", "<C-u>zz")

remap("v", "J", ":m '>+1<CR>gv=gv")
remap("v", "K", ":m '<-2<CR>gv=gv")
