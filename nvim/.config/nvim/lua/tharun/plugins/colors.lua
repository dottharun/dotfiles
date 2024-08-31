return {
    -- custom colorsheme
    {
        "tjdevries/colorbuddy.nvim",
        config = function()
            vim.cmd.colorscheme("gruvbuddy")
            vim.cmd.colorscheme("hacker-dark")
        end,
    },
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            function Od()
                require("onedark").setup({
                    -- style = 'warmer',
                    code_style = {
                        comments = "none",
                        keywords = "none",
                        functions = "none",
                        strings = "none",
                        variables = "none",
                    },
                    colors = {
                        bg0 = "#111111",
                        bg1 = "#000000",
                    },
                })

                require("onedark").load()
            end
            -- Od()
        end,
    },
    {
        "askfiy/visual_studio_code",
        priority = 100,
        config = function()
            -- vim.cmd([[colorscheme visual_studio_code]])
        end,
    },
}
