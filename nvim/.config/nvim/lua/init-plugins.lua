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

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
augroup packer_user_config
autocmd!
autocmd BufWritePost init-plugins.lua source <afile> | PackerSync
augroup end
]])

packer = require("packer")
return packer.startup(function(use)
    -- packer can manage itself
    use("wbthomason/packer.nvim")
    use("nvim-lua/plenary.nvim")

    use("bluz71/vim-nightfly-guicolors")
    use("christoomey/vim-tmux-navigator")

    -- essential plugins
    use("nvim-treesitter/nvim-treesitter", {run = ":TSUpdate"})
    use("tpope/vim-surround")
    use("tpope/vim-vinegar")
    use("tpope/vim-fugitive")
    use("vim-scripts/ReplaceWithRegister")
    use("numToStr/Comment.nvim")
    use("mbbill/undotree")
    use {
        "907th/vim-auto-save",
        config = function () vim.g.auto_save = 1 end
    }

    -- fuzzy finding w/ telescope
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
    use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

    -- language servers and all the jazz
    use("neovim/nvim-lspconfig")
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        requires = {
            -- LSP Support

            -- Autocompletion
            {"hrsh7th/nvim-cmp"},     -- Required
            {"hrsh7th/cmp-nvim-lsp"}, -- Required
            {"L3MON4D3/LuaSnip"},     -- Required
        }
    }

    use {
        "APZelos/blamer.nvim",
        config = function () vim.g.blamer_enabled = 1 end
    }

    if packer_bootstrap then
        require("packer").sync()
    end
end)

