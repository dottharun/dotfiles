vim.g.mapleader = " "

-- netrw explorer shortcut
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<leader>pv", "<cmd>Ex .<CR>")

vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>")

-- Esc to normal mode
local options = { noremap = true }
vim.keymap.set("i", "jj", "<Esc>", options)
vim.keymap.set("i", "jk", "<Esc>", options)
--vim.keymap.set("i", "kj", "<Esc>", options)

--quick buffer switch
vim.keymap.set("n", "<leader><leader>", "<C-^>", options)

--vim-cmdline-window and go to insert mode
vim.keymap.set("n", "<leader>:", "q:i", options)

--primeagen
--move in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

--Join lines from below without changing cursor position
-- SplitJoin extension does the same too -lets see if i really use it or it works all the time
vim.keymap.set("n", "J", "mzJ`z")

-- centering view during page moves and search strings
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

-- tmux-sessionizer - need this to work in nvim
vim.keymap.set("n", "<C-f>", "<cmd>!tmux neww ~/.local/scripts/tmux-sessionizer<CR>")

-- just trying to get vim-cmd-window to work with remap
vim.keymap.set("n", "<leader>//", [[yiwq:i%s/\<<Esc>pa\>/<Esc>pa/gI<Left><Left><Left>]])

-- SEARCH AND REPLACE
-- all file
vim.keymap.set("n", "<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- current line and down
vim.keymap.set("n", "<leader>sd", [[:.,$s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- on visual selection only --kinda funky since selection has to be made afterwords
vim.keymap.set("v", "<leader>s", [[:s/\<\>/foo/gI<Left><Left><Left><Left><Left><Left><Left><Left><Left>]])

-- make current file executable (for bash files)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- open vim plug
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/dotfiles/nvim/.config/nvim/lua/tharun/plug.vim<CR>");
-- open vim theme page
vim.keymap.set("n", "<leader>vtt", "<cmd>e ~/dotfiles/nvim/.config/nvim/after/plugin/colors.lua<CR>");

vim.keymap.set("n", "<leader>vso", function()
    print("hello from sourcing init")
    vim.cmd("so ~/dotfiles/nvim/.config/nvim/init.lua")
end)
