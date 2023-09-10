require("mason").setup()
require("mason-lspconfig").setup()

local use_servers = {
    -- language servers
    "bashls",
    "dockerls",
    "jsonls",
    "lua_ls",
    "vimls",
    "marksman",
    "pyright",
    "taplo",
}


local lsp = require("lsp-zero")
lsp.preset("recommended")
lsp.ensure_installed(use_servers)

local cmp = require("cmp")
cmp.setup({
    mapping = {
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<Tab>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
    }
})

-- prepare common stuff
local on_attach = lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({ buffer = bufnr })
end)
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Configure all language servers
local lspconfig = require "lspconfig"
for _, lsp in ipairs(use_servers) do
    lspconfig[lsp].setup {
        capabilities = capabilities,
        on_attach = on_attach
    }
end

lsp.setup()
