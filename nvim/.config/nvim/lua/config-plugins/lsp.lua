local lsp = require("lsp-zero").preset("minimal")
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({buffer = bufnr})
end)

-- Configure lua language server for neovim
local lspconfig = require "lspconfig"
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()
