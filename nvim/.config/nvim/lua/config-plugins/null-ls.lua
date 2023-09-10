local null_ls = require "null-ls"

local opts = {
    sources = {
        null_ls.builtins.diagnostics.ruff,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.beautysh,
    }
}
null_ls.setup(opts)

return opts
