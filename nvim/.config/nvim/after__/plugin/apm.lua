local apm = require("vim-apm")

apm:setup({})
vim.keymap.set("n", "<leader>vaa", function() apm:toggle_monitor() end)
