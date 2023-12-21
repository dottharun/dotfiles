call plug#begin()

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }

" nav
Plug 'ThePrimeagen/harpoon', { 'branch': 'harpoon2' }

" theme
Plug 'rose-pine/neovim', { 'as': 'rose-pine'}
Plug 'gruvbox-community/gruvbox'
Plug 'olivercederborg/poimandres.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'numToStr/Comment.nvim'

Plug 'mbbill/undotree'

" latex math
Plug 'sirver/ultisnips'
Plug 'lervag/vimtex' " latex compiler wrapper

" lsp-zero
"  Uncomment these if you want to manage LSP servers from neovim
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
