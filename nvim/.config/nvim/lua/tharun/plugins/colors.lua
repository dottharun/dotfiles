return {
    -- custom colorsheme
    {
        "tjdevries/colorbuddy.nvim",
        config = function()
            -- vim.cmd.colorscheme("gruvbuddy")
            -- vim.cmd.colorscheme("hacker-dark")
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
            Od()

            function OneLight()
                require("onedark").setup({
                    style = "light",
                    code_style = {
                        comments = "none",
                        keywords = "none",
                        functions = "none",
                        strings = "none",
                        variables = "none",
                    },
                    colors = {
                        bg0 = "#ffffff",
                        bg1 = "#f0f0f0",
                    },
                })
                require("onedark").load()
            end

            vim.api.nvim_set_keymap(
                "n",
                "<leader>td",
                ":hi clear | colorscheme onedark<CR>",
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>tv",
                ":hi clear | colorscheme visual_studio_code<CR>",
                { noremap = true, silent = true }
            )

            vim.api.nvim_set_keymap(
                "n",
                "<leader>tl",
                ":hi clear | lua OneLight()<CR>",
                { noremap = true, silent = true }
            )
            vim.api.nvim_set_keymap("n", "<C-c>", ":hi clear | lua OneLight()<CR>", { noremap = true, silent = true })
        end,
    },
    {
        "askfiy/visual_studio_code",
        priority = 100,
        config = function()
            -- vim.cmd([[colorscheme visual_studio_code]])
        end,
    },
    {
        "nyoom-engineering/oxocarbon.nvim",
        priority = 100,
        config = function()
            -- vim.cmd([[colorscheme oxocarbon]])
        end,
    },
    {
        "folke/tokyonight.nvim",
        priority = 100,
        config = function()
            -- vim.cmd([[colorscheme tokyonight-night]])
        end,
    },
    {
        "RRethy/base16-nvim",
        priority = 100,
        config = function()
            -- vim.cmd([[colorscheme tokyonight]])
        end,
    },
}
