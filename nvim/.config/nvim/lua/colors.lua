-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
vim.opt.termguicolors = true
vim.cmd [[colorscheme nightfly]]
vim.opt.background = "dark" -- colorschemes that can be light or dark will be made dark
vim.opt.showmode = false -- lightline already shows the current mode
vim.g.lightline = { colorscheme = "nord" }

