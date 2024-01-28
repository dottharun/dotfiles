--print("hello from after tex ftplugin")

local options = { noremap = true }

--save, compile, view
vim.keymap.set("n", "<leader>rt", "<Cmd>update<CR><Cmd>VimtexCompile<CR><Esc>", options)
vim.keymap.set("n", "<leader>rk", "<Cmd>VimtexStop<CR>", options)
vim.keymap.set("n", "<leader>rc", "<Cmd>VimtexClean<CR>", options)
vim.keymap.set("n", "gv", "<Cmd>VimtexView<CR>", options)
vim.keymap.set("n", "ge", "<Cmd>VimtexErrors<CR>", options)
vim.keymap.set("n", "gt", "<Cmd>VimtexTocOpen<CR>", options)

-- change delete toggle
vim.keymap.set("n", "dsm", "<Plug>(vimtex-env-delete-math)")
vim.keymap.set("n", "csm", "<Plug>(vimtex-env-change-math)")
vim.keymap.set("n", "tsm", "<Plug>(vimtex-env-toggle-math)")

-- spell check
vim.opt_local.spell = true
vim.opt_local.spelllang = 'en_us'
vim.keymap.set("i", "<C-z>", "<c-g>u<C-[>[s1z=`]a<c-g>u", options)

vim.opt.conceallevel = 1
-- vim.cmd [[TSContextDisable]]

-- personal
-- vim.cmd("setlocal nolist")
