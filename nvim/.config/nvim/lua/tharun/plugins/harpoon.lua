return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() 
	    local harpoon = require("harpoon")

	    -- REQUIRED
	    harpoon:setup()
	    -- REQUIRED

	    vim.keymap.set("n", "<C-m>", function() harpoon:list():add() end)
	    vim.keymap.set("n", "<leader>a", function()
		    print("added to harpoon")
		    harpoon:list():add()
	    end, { desc = "add buffer to harpoon" })

	    vim.keymap.set("n", "<c-e>", function()
		    harpoon.ui:toggle_quick_menu(harpoon:list())
	    end, { desc = "open harpoon [b]uffer list" })

	    vim.keymap.set("n", "<leader>b", function()
		    harpoon.ui:toggle_quick_menu(harpoon:list())
	    end, { desc = "open harpoon [b]uffer list" })

	    vim.keymap.set("n", "<leader>h", function() harpoon:list():select(1) end, { desc = "goto harpoon - 1" })
	    vim.keymap.set("n", "<leader>j", function() harpoon:list():select(2) end, { desc = "goto harpoon - 2" })
	    vim.keymap.set("n", "<leader>k", function() harpoon:list():select(3) end, { desc = "goto harpoon - 3" })
	    vim.keymap.set("n", "<leader>l", function() harpoon:list():select(4) end, { desc = "goto harpoon - 4" })

	    -- Toggle previous & next buffers stored within Harpoon list ---TODO configure alacritty for this keymap
	    vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
	    vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
    end
}
