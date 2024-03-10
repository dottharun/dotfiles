vim.g.mapleader = " "

-- netrw explorer shortcut
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
-- vim.keymap.set("n", "<leader>pv", "<cmd>Ex .<CR>")

vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>")

vim.keymap.set("n", "<leader><leader>", "<cmd>write<CR>", { desc = "Save current file" })
vim.keymap.set({"n", "i", "v"}, "<C-s>", "<cmd>write<CR>", { desc = "Save current file" })  -- will work when tmux key is disabled

local options = { noremap = true }
-- Esc to normal mode
-- vim.keymap.set("i", "jj", "<Esc>", options)
-- vim.keymap.set("i", "jk", "<Esc>", options)
-- vim.keymap.set("i", "kj", "<Esc>", options)

-- vscode like commenting with Ctrl+/ in both normal and insert mode, ---might break something else need to check correctly
vim.keymap.set('n', '', '<Plug>(comment_toggle_linewise_current)')
vim.keymap.set('i', '', '<ESC><Plug>(comment_toggle_linewise_current)A')
vim.keymap.set('n', '<leader>c', '<Plug>(comment_toggle_linewise_current)') -- lets see if i really use it

-- quick buffer switch
vim.keymap.set("n", "<leader>^", "<C-^>", options)
vim.keymap.set("n", "<leader>n", "<C-^>", options)

--vim window motions
vim.keymap.set("n", "<leader>w", "<C-w>", { desc = "vim window motions" })

-- vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move cursor bottom window" })
-- vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move cursor right window" })
-- vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move cursor top window" })
-- vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move cursor left window" })

-- for easy movement when wrap is enabled - they say
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

--primeagen
--move in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Join lines from below without changing cursor position
-- SplitJoin extension does the same too -lets see if i really use it or it works all the time
vim.keymap.set("n", "J", "mzJ`z")

-- centering view during page moves and search strings
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- living overwrite paste - don't forget to use leader+p not raw p
vim.keymap.set("x", "<leader>p", [["_dP]])

-- leader+y to yank to system clipboard and similars
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- tmux-sessionizer - need this to work in nvim
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.local/scripts/tmux-sessionizer<CR>")

-- SEARCH AND REPLACE
-- all file
vim.keymap.set("n", "<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- current line and down
vim.keymap.set("n", "<leader>sd", [[:.,$s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- on visual selection only --kinda funky since selection has to be made afterwords
vim.keymap.set("v", "<leader>s", [[:s/\<\>/foo/gI<Left><Left><Left><Left><Left><Left><Left><Left><Left>]])

vim.keymap.set("n", "<leader>xx", "<cmd>!chmod +x %<CR>", { silent = true, desc = "make curr file executable" })
vim.keymap.set("n", "<leader>xr", "<cmd>!chmod -x %<CR>", { silent = true, desc = "revert curr file as executable" })

-- open vim plug
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/dotfiles/nvim/.config/nvim/lua/tharun/plug.vim<CR>");
-- open vim theme page
vim.keymap.set("n", "<leader>vtt", "<cmd>e ~/dotfiles/nvim/.config/nvim/after/plugin/colors.lua<CR>");

-- for the giggles
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader>vso", function()
    print("hello from sourcing init")
    vim.cmd("so ~/dotfiles/nvim/.config/nvim/init.lua")
end)
