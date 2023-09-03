-- The working man setup
vim.g.mapleader = " "
local keymap = vim.keymap

keymap.set("n", "<leader>nh", ":nohl<CR>") -- clear search highlight

-- window management
keymap.set("n", "<leader>|", "<C-w>v") -- vertical split
keymap.set("n", "<leader>\\", "<C-w>s") -- horizontal split
keymap.set("n", "<leader>--", ":close<CR>") -- close current split
keymap.set("n", "<leader>==", "<C-w>=") -- make split equal

-- tabs management
keymap.set("n", "<leader>t+", ":tabnew<CR>")
keymap.set("n", "<leader>t-", ":tabclose<CR>")
keymap.set("n", "<leader>t[", ":tabp<CR>")
keymap.set("n", "<leader>t]", ":tabn<CR>")

keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
keymap.set("n", "<leader>gs", vim.cmd.Git)

