call plug#begin()

Plug 'nvim-lua/plenary.nvim'

" code
Plug 'AndrewRadev/splitjoin.vim'
Plug 'numToStr/Comment.nvim'
Plug 'JoosepAlviste/nvim-ts-context-commentstring' "for react comments

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired' "all left right movement
Plug 'tpope/vim-abolish' " find and replace
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb' " github
Plug 'tpope/vim-eunuch' " unix commands
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-fugitive'

" nav
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'ThePrimeagen/harpoon', { 'branch': 'harpoon2' }

" theme
Plug 'rose-pine/neovim', { 'as': 'rose-pine'}
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'folke/tokyonight.nvim'
Plug 'rebelot/kanagawa.nvim'
Plug 'Mofiqul/vscode.nvim'

Plug 'Eandrju/cellular-automaton.nvim' "for the giggles

" Plug 'RRethy/vim-illuminate'
Plug 'j-hui/fidget.nvim'
" Plug 'nvim-tree/nvim-web-devicons' " feels weird

Plug 'mbbill/undotree'
Plug 'CRAG666/code_runner.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'folke/which-key.nvim'
Plug 'ThePrimeagen/vim-apm'
Plug 'kdheepak/lazygit.nvim'
Plug 'jiangmiao/auto-pairs'   " for the leetcode defaults

" latex math
Plug 'sirver/ultisnips'
let g:UltiSnipsJumpBackwardTrigger = "<C-b>"
let g:UltiSnipsExpandOrJumpTrigger = "<tab>"  " might use later
" let g:UltiSnipsJumpForwardTrigger = "jk"

Plug 'lervag/vimtex' " latex compiler wrapper , probably need to be removed giving many headaches

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'

" lsp-zero requires
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
" LSP Support
Plug 'neovim/nvim-lspconfig'
" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'

Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v3.x'}

Plug 'davidosomething/format-ts-errors.nvim'
Plug 'mhartington/formatter.nvim'
Plug 'moliva/inlay-hints.nvim', {'branch': 'feat/disable-tsserver-adapter'} "experimental custom branch by someone else need to find solution
Plug 'marilari88/twoslash-queries.nvim'

Plug 'Exafunction/codeium.vim', { 'branch': 'main' }
Plug 'honza/vim-snippets'

call plug#end()
