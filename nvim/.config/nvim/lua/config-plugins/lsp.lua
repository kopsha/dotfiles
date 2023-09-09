local cmp = require("cmp")
local lsp = require("lsp-zero").preset("minimal")

cmp.setup({
    mapping = {
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-y>"] = cmp.config.disable,
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
    }
})


lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({ buffer = bufnr })
end)

-- Configure lua language server for neovim
local lspconfig = require "lspconfig"
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()
