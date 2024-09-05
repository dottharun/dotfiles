vim.g.mapleader = " "

vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>write<CR>", { desc = "Save current file" }) -- will work when tmux key is disabled

-- controlling lsp
vim.keymap.set("n", "<leader>vrs", "<cmd>LspRestart<CR><Esc>")
vim.keymap.set("n", "<leader>vv", "<cmd>LspStart<CR><Esc>")
vim.keymap.set("n", "<leader>vk", "<cmd>LspStop<CR><Esc>")
vim.keymap.set("n", "<leader>vi", "<cmd>LspInfo<CR><Esc>")

local options = { noremap = true }
-- controlling lsp
vim.keymap.set("n", "<leader>vrs", "<cmd>LspRestart<CR><Esc>")
vim.keymap.set("n", "<leader>vv", "<cmd>LspStart<CR><Esc>")
vim.keymap.set("n", "<leader>vk", "<cmd>LspStop<CR><Esc>")
vim.keymap.set("n", "<leader>vi", "<cmd>LspInfo<CR><Esc>")

-- wrap and nowrap
vim.keymap.set("n", "<leader>ww", "<cmd>set wrap<CR><Esc>")
vim.keymap.set("n", "<leader>wk", "<cmd>set nowrap<CR><Esc>")

-- view plugin logs
vim.keymap.set("n", "<leader>ms", ":mes<CR>", { desc = "messages" })

-- quick buffer switch
vim.keymap.set("n", "<leader>^", "<C-^>", options)
vim.keymap.set("n", "<leader><leader>", "<cmd>so<CR>", options)

-- for easy movement when wrap is enabled - they say
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

vim.keymap.set("n", "<leader>cd", ":cd %:h<CR>", { desc = "change dir" })
-- may help in splits ??
vim.keymap.set("n", "<leader>cld", ":lcd %:h<CR>", { desc = "change dir local" })

--move in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Join lines from below without changing cursor position
-- SplitJoin extension does the same too -lets see if i really use it or it works all the time
vim.keymap.set("n", "J", "mzJ`z")

-- centering view during page moves and search strings
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- elaborate setup to make C-d, work in last line
vim.keymap.set("n", "<C-d>", function()
    if vim.fn.line(".") == vim.fn.line("$") then
        vim.cmd("normal! zz")
    else
        vim.cmd([[exe "normal! \<c-d>zz"]])
    end
end, options)

-- goto top and bottom of quickfixlist
vim.keymap.set("n", "<C-t>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<C-b>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-S-t>", "<cmd>lprev<CR>zz")
vim.keymap.set("n", "<C-S-b>", "<cmd>lnext<CR>zz")

vim.keymap.set("n", "<leader>qq", "<cmd>cclose<CR>")
vim.keymap.set("n", "<leader>ql", "<cmd>lclose<CR>")

-- living overwrite paste - don't forget to use leader+p not raw p
vim.keymap.set("x", "<leader>p", [["_dP]])

-- leader+y to yank to system clipboard and similars
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- paste from clipboard -- for firenvim
vim.keymap.set("n", "<C-S-v>", '"+p', { noremap = true, silent = true })

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
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/dotfiles/nvim/.config/nvim/lua/tharun/plug.vim<CR>")
-- open vim theme page
vim.keymap.set("n", "<leader>vtt", "<cmd>e ~/dotfiles/nvim/.config/nvim/after/plugin/colors.lua<CR>")

-- for the giggles
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

vim.keymap.set("n", "<leader>vso", function()
    print("hello from sourcing init")
    vim.cmd("so ~/dotfiles/nvim/.config/nvim/init.lua")
end)
