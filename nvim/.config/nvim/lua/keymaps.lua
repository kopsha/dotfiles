-- The working man setup
vim.g.mapleader = "\\"
local keymap = vim.keymap

-- window management
keymap.set("n", "<leader>|", "<C-w>v")  -- vertical split
keymap.set("n", "<leader>\\", "<C-w>s") -- horizontal split

keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
keymap.set("n", "<leader>gs", vim.cmd.Git)

-- smart block move
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- append line bellow to current line but keep cursor position
keymap.set("n", "J", "mzJ`z")

-- keep cursor in the middle
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- keep search terms in the middle
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- quickfixlist navigation
keymap.set("n", "<M-k>", "<cmd>cnext<CR>zz")
keymap.set("n", "<M-j>", "<cmd>cprev<CR>zz")
keymap.set("n", "<M-q>", "<cmd>cclose<CR>")

-- format current buffer
keymap.set("n", "<leader>==", function() vim.lsp.buf.format() end)

-- replace text under cursor
keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Jump to start and end of line
keymap.set({"n", "v"}, "H", "^", { noremap = true, silent = true })
keymap.set({"n", "v"}, "L", "$", { noremap = true, silent = true })

keymap.set({"n", "v"}, "<leader>/", "<cmd>:nohlsearch<CR>")
keymap.set("n", "Q", "<nop>")

