-- The working man setup
vim.g.mapleader = "\\"
local keymap = vim.keymap

-- window management
keymap.set("n", "<leader>|", "<C-w>v")  -- vertical split
keymap.set("n", "<leader>\\", "<C-w>s") -- horizontal split
keymap.set("n", "<leader>==", "<C-w>=") -- make split equal
keymap.set("n", "<leader>x", ":close<CR>", { noremap = true })

-- tabs management
keymap.set("n", "<leader>t", ":tabnew<CR>")
keymap.set("n", "<leader>t-", ":tabclose<CR>")
keymap.set("n", "<leader>t[", ":tabp<CR>")
keymap.set("n", "<leader>t]", ":tabn<CR>")

keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
keymap.set("n", "<leader>gs", vim.cmd.Git)

-- smart block move
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '>-2<CR>gv=gv")

-- append line bellow to current line but keep cursor position
keymap.set("n", "J", "mzJ`z")

-- keep cursor in the middle
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- keep search terms in the middle
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- quickfixlist navigation
keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- format current buffer
keymap.set("n", "<leader>{}", function() vim.lsp.buf.format() end)

-- replace text under cursor
keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
