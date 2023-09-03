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

-- telescope
local builtin = require "telescope.builtin"
keymap.set("n", "<leader>ff", builtin.find_files, {})
keymap.set("n", "<leader>fc", builtin.grep_string, {})
keymap.set("n", "<leader>fg", builtin.live_grep, {})
keymap.set("n", "<leader>fb", builtin.buffers, {})
keymap.set("n", "<leader>fh", builtin.help_tags, {})

keymap.set("n", "<leader>gf", builtin.git_files, {})
keymap.set("n", "<leader>gc", builtin.git_commits, {})
keymap.set("n", "<leader>gh", builtin.git_bcommits, {})
keymap.set("n", "<leader>gb", builtin.git_branches, {})
keymap.set("n", "<leader>gs", builtin.git_status, {})

