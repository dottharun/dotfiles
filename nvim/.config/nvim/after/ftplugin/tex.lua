-- print("hello from after tex ftplugin")

--save, compile, view
vim.keymap.set("n", "<leader>rt", "<Cmd>update<CR><Cmd>VimtexCompile<CR><Esc>", { noremap = true, desc = "start tex compiler in watch mode" })
vim.keymap.set("n", "<leader>rk", "<Cmd>VimtexStop<CR>", { noremap = true, desc = "kill tex compiler" })
vim.keymap.set("n", "<leader>rc", "<Cmd>VimtexClean<CR>", { noremap = true, desc = "clean extra tex files" })
vim.keymap.set("n", "gp", "<Cmd>VimtexView<CR>", { noremap = true, desc = "goto tex pdf view" })
vim.keymap.set("n", "ge", "<Cmd>VimtexErrors<CR>", { noremap = true, desc = "goto tex errors" })
vim.keymap.set("n", "gt", "<Cmd>VimtexTocOpen<CR>", { noremap = true, desc = "goto tex table of contents" })

-- change delete toggle
vim.keymap.set("n", "dsm", "<Plug>(vimtex-env-delete-math)")
vim.keymap.set("n", "csm", "<Plug>(vimtex-env-change-math)")
vim.keymap.set("n", "tsm", "<Plug>(vimtex-env-toggle-math)")

-- spell check
-- vim.opt_local.spell = true
vim.opt_local.spelllang = 'en_us'
vim.keymap.set("i", "<C-p>", "<c-g>u<C-[>[s1z=`]a<c-g>u", { noremap = true, desc = "correct prev mistake" })

vim.opt.conceallevel = 0

-- disables ts context
vim.cmd [[TSContextDisable]]
--
-- disables TS highlight
vim.cmd [[DisableHL]]

-- personal
-- vim.cmd("setlocal nolist")
--

