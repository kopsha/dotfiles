-- huh
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Buffer navigation
vim.keymap.set("n", "<Tab>", ":bnext<CR>")
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>")
vim.keymap.set("n", "<leader>b", ":Buffers<CR>")
vim.keymap.set("n", "<leader>d", ":bdelete!<CR>")

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Smart block move
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Quickfixlist navigation
local function toggle_quickfix()
	local qf_exists = vim.fn.getqflist({ winid = 1 }).winid ~= 0
	if qf_exists then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end
vim.keymap.set("n", "<leader>q", toggle_quickfix, { desc = "Toggle Quickfix" })
vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>zz")

-- Jump to start and end of line
vim.keymap.set({ "n", "v" }, "H", "^", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "L", "$", { noremap = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>w", vim.diagnostic.setloclist, { desc = "Open diagnostic Quickfix list" })

-- Append line bellow to current line but keep cursor position
vim.keymap.set("n", "J", "mzJ`z")

-- Keep search terms in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Automatically close brackets, parethesis, and quotes
vim.keymap.set("i", "'", "''<left>")
vim.keymap.set("i", '"', '""<left>')
vim.keymap.set("i", "(", "()<left>")
vim.keymap.set("i", "[", "[]<left>")
vim.keymap.set("i", "{", "{}<left>")
vim.keymap.set("i", "<", "<><left>")
vim.keymap.set("i", "/*", "/**/<left><left>")

-- Replace all instances of highlighted word
vim.keymap.set("v", "<leader>rw", '"hy:%s/<C-r>h//g<left><left>')
