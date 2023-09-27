require("mason").setup()
require("mason-lspconfig").setup()

local use_servers = {
    -- language servers
    { name = "bashls" },
    { name = "dockerls" },
    { name = "jsonls" },
    { name = "lua_ls" },
    { name = "vimls" },
    { name = "marksman" },
    {
        name = "pyright",
        settings = {
            python = {
                analysis = {
                    autoImportCompletions = false,
                }
            }
        }
    },
    { name = "taplo" },
    { name = "tsserver" },
}

local lsp = require("lsp-zero")
lsp.preset("recommended")
lsp.ensure_installed(use_servers)
require("mason-null-ls").setup({
    ensure_installed = {
        "ruff",
        "black",
        "isort",
        "beautysh",
    }
})

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

for _, server in ipairs(use_servers) do
    local config = {
        capabilities = capabilities,
        on_attach = on_attach
    }

    if server.settings then
        config.settings = server.settings
    end

    lspconfig[server.name].setup(config)
end

lsp.setup()
