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
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- telescope git commands (not on youtube nvim video)
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]
