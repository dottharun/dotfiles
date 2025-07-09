return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            image = { doc = { max_width = 140, max_height = 80 } },
        },
    },
    {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
            default = {
                relative_to_current_file = true,
            },
        },
        keys = {
            -- suggested keymap
            -- { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
        },
    },
}
