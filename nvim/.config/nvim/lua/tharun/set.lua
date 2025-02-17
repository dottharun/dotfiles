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
vim.g.editorconfig = false -- stops nvim from respecting editorconfig
vim.opt.fixendofline = false -- stops nvim from autofixing end-of-line during save

-- to disable conform autoformat
-- vim.g.disable_autoformat = true

-- turn off that mouse always disturbing
vim.opt.mouse = "nv"

-- statusline
vim.opt.laststatus = 3

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

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.diagnostic.config({
    -- update_in_insert = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})
