-- auto install packer if not installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins when file is saved
vim.cmd([[
augroup packer_user_config
    autocmd!
    autocmd BufWritePost init-plugins.lua source <afile> | PackerSync
augroup end
]])

local packer = require("packer")
return packer.startup(function(use)
    use("wbthomason/packer.nvim")
    use("nvim-lua/plenary.nvim")

    use("christoomey/vim-tmux-navigator")
    use("itchyny/lightline.vim")
    use("bluz71/vim-nightfly-guicolors")

    -- essential plugins
    use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
    use("tpope/vim-surround")
    use("tpope/vim-endwise")
    use("rstacruz/vim-closer")
    use("tpope/vim-vinegar")
    use("tpope/vim-fugitive")
    use("tpope/vim-commentary")
    use("tpope/vim-repeat")

    use("mbbill/undotree")
    use {
        "echasnovski/mini.splitjoin",
        branch = "stable",
        config = function() require("mini.splitjoin").setup() end
    }

    -- fuzzy finding w/ telescope
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
    use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })        -- fuzzy finder

    -- language servers and all the jazz
    use {
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "jay-babu/mason-null-ls.nvim" },
        config = function()
            require "config-plugins.null-ls"
        end,
    }
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("neovim/nvim-lspconfig")
    use { "L3MON4D3/LuaSnip", tag = "v2.*" }
    use {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        requires = {
            -- LSP Support
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "neovim/nvim-lspconfig" },
            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },
        }
    }
    use { "towolf/vim-helm", ft = "helm" }

    use {
        "APZelos/blamer.nvim",
        config = function() vim.g.blamer_enabled = 1 end
    }

    use { "kopsha/vim-saver", tag = "1.*" } -- don't worry, there is no sugar!

    if packer_bootstrap then
        require("packer").sync()
    end
end)
