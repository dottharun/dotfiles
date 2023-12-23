vim.g.mapleader = " "

-- netrw explorer shortcut
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- Esc to normal mode
local options = { noremap = true }
vim.keymap.set("i", "jj", "<Esc>", options)
vim.keymap.set("i", "jk", "<Esc>", options)
--vim.keymap.set("i", "kj", "<Esc>", options)

--quick buffer switch
vim.keymap.set("n", "<leader><leader>", "<C-^>", options)

--save
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>")
vim.keymap.set({ "n" }, "<leader>w", "<cmd>w<CR><esc>")
--only format
vim.keymap.set("n", "<leader>m", vim.lsp.buf.format, options)

--primeagen
--move in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- centering view during page moves and search strings
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
-- living overwrite paste - dont forget use leader+p not raw p
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- leader+y to yank to system clipboard and similars
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
