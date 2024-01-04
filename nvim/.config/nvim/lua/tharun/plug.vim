call plug#begin()

Plug 'nvim-lua/plenary.nvim'

" code
Plug 'AndrewRadev/splitjoin.vim'
Plug 'numToStr/Comment.nvim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" nav
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
Plug 'ThePrimeagen/harpoon', { 'branch': 'harpoon2' }
Plug 'stevearc/oil.nvim'
Plug 'ggandor/leap.nvim'
Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" theme
Plug 'rose-pine/neovim', { 'as': 'rose-pine'}
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'folke/tokyonight.nvim'
Plug 'rebelot/kanagawa.nvim'
Plug 'EdenEast/nightfox.nvim' " Vim-Plug

Plug 'mbbill/undotree'

" latex math
Plug 'sirver/ultisnips'
Plug 'lervag/vimtex' " latex compiler wrapper

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

call plug#end()
