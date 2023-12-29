--print("hello from after tex ftplugin")

local options = { noremap = true }
--save, compile, view
vim.keymap.set("n", "<leader>r", "<Cmd>update<CR><Cmd>VimtexCompile<CR>", options)
vim.keymap.set("n", "<leader>k", "<Cmd>VimtexStop<CR>", options)
vim.keymap.set("n", "<leader>c", "<Cmd>VimtexClean<CR>", options)
vim.keymap.set("n", "<leader>vv", "<Cmd>VimtexView<CR>", options)
vim.keymap.set("n", "<leader>ve", "<Cmd>VimtexErrors<CR>", options)
vim.keymap.set("n", "<leader>vt", "<Cmd>VimtexTocOpen<CR>", options)

-- change delete toggle
vim.keymap.set("n", "dsm", "<Plug>(vimtex-env-delete-math)")
vim.keymap.set("n", "csm", "<Plug>(vimtex-env-change-math)")
vim.keymap.set("n", "tsm", "<Plug>(vimtex-env-toggle-math)")
-- spell check
vim.opt_local.spell = true
vim.opt.spelllang = 'en_us'
vim.keymap.set("i", "<C-z>", "<c-g>u<C-[>[s1z=`]a<c-g>u", options)


-- personal
-- vim.cmd("setlocal nolist")
