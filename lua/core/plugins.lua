local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- My plugins here
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- LSP Support
    use({ 'neovim/nvim-lspconfig' })
    use({
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    })
    use({
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    })

    -- autopairs and autotag
    use({ "windwp/nvim-autopairs" })
    use({
        "windwp/nvim-ts-autotag",
        ft = { "html" },
        lazy = true,
        config = true,
    })

    -- predefined snippets
    use({ "rafamadriz/friendly-snippets" })

    -- Treesitter for code highlighting
    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })

    -- Color scheme
    -- use { "catppuccin/nvim", as = "catppuccin" }
    use({ 'projekt0n/github-nvim-theme', as = 'github-theme' })

    -- Status line at the bottom
    use {
        'nvim-lualine/lualine.nvim',
    }

    -- format on save
    use({
        "stevearc/conform.nvim",
    })
    use({ 'numToStr/prettierrc.nvim' });

    -- comment visual regions/lines
    use({ "numToStr/Comment.nvim" })

    -- Copilot
    use({ "github/copilot.vim" })

    --- github
    use({ "lewis6991/gitsigns.nvim" })

    -- file explorer
    use { 'nvim-tree/nvim-tree.lua' }
    use { 'nvim-tree/nvim-web-devicons' }

    use({ 'echasnovski/mini.nvim' })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
