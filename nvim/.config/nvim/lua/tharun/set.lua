vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- vim.opt.list = true
-- vim.opt.listchars = {
--     eol = '↲',
--     tab = '» ',
--     trail = '·',
--     extends = '<',
--     precedes = '>',
--     conceal = '┊',
--     nbsp = '␣',
-- }

-- had to do it for the meshery repo
vim.g.editorconfig = false

vim.cmd([[
" status line
set statusline=%<\ %{mode()}\ \|\ %f%m
set statusline+=%{&paste?'\ \ \|\ PASTE\ ':'\ '}
set statusline+=%=\ %l/%L\(%c\)\ \|\ %{&fileformat}\ \|\ %{&fileencoding}\ \|\ %{&filetype}
set statusline+=%{'\ '}

" syntax highlighting
syntax sync minlines=256
]])

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true -- Do not ignore case, if uppercase is in search term

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
