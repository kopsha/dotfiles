require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = {
        "bashls",
        "dockerls",
        "jsonls",
        "quick_lint_js",
        "lua_ls",
        "marksman",
        "pyright",
        "sourcery",
        "taplo",
    }
}

