-- print("hello from plugins")

return {
    {
        "nvim-lua/plenary.nvim",
    },
    {
        "mechatroner/rainbow_csv",
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    },
    { "Eandrju/cellular-automaton.nvim", dependencies = { "nvim-treesitter/nvim-treesitter" } },
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({ signcolumn = true })

            -- vim.keymap.set("n", "<leader>Gs", ":Gitsigns toggle_signs<CR>")
            vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk_inline<CR>")
            vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>")
            vim.keymap.set("n", "<leader>ga", ":Gitsigns stage_hunk<CR>")
        end,
    },
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 1000
            require("which-key").setup({})
        end,
    },
    {
        "kdheepak/lazygit.nvim",
        config = function()
            vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>")
        end,
    },
    {
        "kwakzalver/duckytype.nvim",
        config = function()
            require("duckytype").setup({
                number_of_words = 30,
            })

            vim.keymap.set("n", "<leader>mt", ":DuckyType<CR>", { desc = "[m]ake [t]ype" })
        end,
    },
}

-- Plug 'nvim-lua/plenary.nvim'
--
-- " code
-- Plug 'AndrewRadev/splitjoin.vim' "not even using it that much and frequently breaks
-- Plug 'numToStr/Comment.nvim'
-- Plug 'JoosepAlviste/nvim-ts-context-commentstring' "for react comments
--
-- Plug 'tpope/vim-repeat'
-- Plug 'tpope/vim-surround'
-- Plug 'tpope/vim-unimpaired' "all left right movement
-- Plug 'tpope/vim-abolish' " find and replace
-- Plug 'tpope/vim-fugitive'
-- Plug 'tpope/vim-rhubarb' " github
-- Plug 'tpope/vim-eunuch' " unix commands
-- Plug 'tpope/vim-rsi'
-- Plug 'tpope/vim-fugitive'
--
-- " nav
-- Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
-- Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
-- Plug 'ThePrimeagen/harpoon', { 'branch': 'harpoon2' }
--
-- Plug 'ThePrimeagen/git-worktree.nvim'
--
-- " theme
-- Plug 'rose-pine/neovim', { 'as': 'rose-pine'}
-- Plug 'sainnhe/gruvbox-material'
-- Plug 'folke/tokyonight.nvim'
-- Plug 'Mofiqul/vscode.nvim'
-- Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
-- Plug 'craftzdog/solarized-osaka.nvim'
-- Plug 'whatyouhide/vim-gotham'
-- Plug 'twerth/ir_black'
-- Plug 'navarasu/onedark.nvim'
-- Plug 'aktersnurra/no-clown-fiesta.nvim'
-- Plug 'ishan9299/nvim-solarized-lua'
--
-- Plug 'norcalli/nvim-colorizer.lua' "colors hex codes
-- Plug 'tjdevries/colorbuddy.nvim'
--
-- Plug 'Eandrju/cellular-automaton.nvim' "for the giggles
--
-- " Plug 'RRethy/vim-illuminate'  " too cluttered
-- Plug 'j-hui/fidget.nvim' " lsp info - very good
-- " Plug 'nvim-tree/nvim-web-devicons' " feels weird
-- Plug 'lukas-reineke/indent-blankline.nvim'
--
-- Plug 'shellRaining/hlchunk.nvim' " breaks all the time
--
-- Plug 'mbbill/undotree'
-- Plug 'lewis6991/gitsigns.nvim'
-- Plug 'folke/which-key.nvim'
-- Plug 'ThePrimeagen/vim-apm'
-- Plug 'kdheepak/lazygit.nvim'
-- " Plug 'jiangmiao/auto-pairs'   " for the leetcode defaults
-- Plug 'folke/trouble.nvim'
--
-- " latex math   --- really needs lazy managing
-- Plug 'sirver/ultisnips'
-- " let g:UltiSnipsJumpBackwardTrigger = "<C-b>"
-- " let g:UltiSnipsExpandOrJumpTrigger = "<tab>"  " might use later
-- " let g:UltiSnipsJumpForwardTrigger = "jk"
-- "
--
-- let g:UltiSnipsExpandTrigger="<tab>"
-- let g:UltiSnipsJumpForwardTrigger="<c-b>"
-- let g:UltiSnipsJumpBackwardTrigger="<c-z>"
--
-- Plug 'lervag/vimtex' " latex compiler wrapper , probably need to be removed giving many headaches
--
-- Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
-- Plug 'nvim-treesitter/nvim-treesitter-context'
-- Plug 'nvim-treesitter/nvim-treesitter-textobjects'
--
-- " lsp-zero requires
-- Plug 'williamboman/mason.nvim'
-- Plug 'williamboman/mason-lspconfig.nvim'
-- " LSP Support
-- Plug 'neovim/nvim-lspconfig'
-- " Autocompletion
-- Plug 'hrsh7th/nvim-cmp'
-- Plug 'hrsh7th/cmp-nvim-lsp'
-- Plug 'L3MON4D3/LuaSnip'
--
-- Plug 'stevearc/conform.nvim'  "trying for c++ might need cleanup later
--
-- Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v3.x'}
--
-- Plug 'davidosomething/format-ts-errors.nvim'
-- Plug 'mhartington/formatter.nvim'
-- Plug 'moliva/inlay-hints.nvim', {'branch': 'feat/disable-tsserver-adapter'} "experimental custom branch by someone else need to find solution
-- Plug 'marilari88/twoslash-queries.nvim'
--
-- Plug 'Exafunction/codeium.vim', { 'branch': 'main' }
-- Plug 'kwakzalver/duckytype.nvim'
