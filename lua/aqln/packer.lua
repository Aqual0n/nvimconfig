-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.3',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- in-vim tmux sessionizer
    use 'viniarck/telescope-tmuxdir.nvim'

    use {
        "folke/tokyonight.nvim",
        command = function()
            vim.cmd('colorscheme tokyonight')
        end
    }

    use("nvim-treesitter/nvim-treesitter-context")
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

    use('ThePrimeagen/harpoon')

    use({
        "okuuva/auto-save.nvim",
        config = function()
            require("auto-save").setup {
                -- your config goes here
                -- or just leave it empty :)
            }
        end,
    })

    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
            require('nvim-autopairs').setup {}
        end
    }

    -- LSP
    use({ 'neovim/nvim-lspconfig' })
    use({ 'mason-org/mason.nvim' })
    use({ 'mason-org/mason-lspconfig.nvim' })
    -- Autocompletion
    use({ 'hrsh7th/cmp-nvim-lsp' })
    use({ 'hrsh7th/cmp-buffer' })
    use({ 'hrsh7th/cmp-path' })
    use({ 'hrsh7th/cmp-cmdline' })
    use({ 'hrsh7th/nvim-cmp'} )
    use({ 'L3MON4D3/LuaSnip' })
    use({ 'saadparwaiz1/cmp_luasnip' })
end)
