return {
    "boganworld/crackboard.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local key = os.getenv("CRACKBOARD_API_KEY")
        require("crackboard").setup({
            session_key = key,
        })
    end,
}
