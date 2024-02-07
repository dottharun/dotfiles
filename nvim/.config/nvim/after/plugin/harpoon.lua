local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<C-m>", function() harpoon:list():append() end)
vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end, { desc = "add buffer to harpoon" })

vim.keymap.set("n", "<leader>t", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "open harpoon tab list" })

vim.keymap.set("n", "<leader>h", function() harpoon:list():select(1) end, { desc = "goto harpoon - 1" })
vim.keymap.set("n", "<leader>j", function() harpoon:list():select(2) end, { desc = "goto harpoon - 2" })
vim.keymap.set("n", "<leader>k", function() harpoon:list():select(3) end, { desc = "goto harpoon - 3" })
vim.keymap.set("n", "<leader>l", function() harpoon:list():select(4) end, { desc = "goto harpoon - 4" })
