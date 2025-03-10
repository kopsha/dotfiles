vim.opt.number = true
vim.opt.relativenumber = true
vim.g.netrw_liststyle = 1

vim.opt.updatetime = 1618
vim.opt.timeoutlen = 618

vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.breakindent = true

vim.opt.undofile = false

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- expand tab to spaces
vim.opt.autoindent = true -- copy indent from current line when starting new one
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.backspace = "indent,eol,start"
vim.opt.wrap = false

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = "split"

vim.opt.cursorline = false
vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"

vim.opt.iskeyword:append("-") -- consider string-string as whole word
