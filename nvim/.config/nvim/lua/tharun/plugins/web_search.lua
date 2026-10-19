return {
    "ulf-westermann/websearch.nvim",
    config = function()
        require("websearch").setup({
            browser = "google-chrome-stable",
            search_key = "<leader>wj",
            search_url = "https://docs.oracle.com/en/java/javase/23/docs/api/search.html?q=",
        })
    end,
}
