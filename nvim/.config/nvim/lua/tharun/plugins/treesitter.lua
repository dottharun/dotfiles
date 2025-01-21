return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("nvim-treesitter.configs").setup({
                -- A list of parser names, or "all"
                ensure_installed = {
                    "html",
                    "css",
                    "json",
                    "jsonc",
                    "jsdoc",
                    "javascript",
                    "typescript",
                    "c",
                    "cpp",
                    "go",
                    "rust",
                    "lua",
                    "vim",
                    "vimdoc",
                    "bash",
                    "query",
                    "java",
                },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
                auto_install = true,

                indent = {
                    enable = true,
                },

                highlight = {
                    -- `false` will disable the whole extension
                    enable = true,
                    disable = { "latex", "csv", "swift" },

                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = { "markdown" },
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("treesitter-context").setup({
                max_lines = 10, -- How many lines the window should span. Values <= 0 mean no limit.
                min_window_height = 20, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
            })

            -- keymap to jump to context
            vim.keymap.set("n", "[c", function()
                require("treesitter-context").go_to_context(vim.v.count1)
            end, { silent = true })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("nvim-treesitter.configs").setup({
                textobjects = {
                    select = {
                        enable = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["aC"] = "@class.outer",
                            ["iC"] = "@class.inner",
                            ["ac"] = "@comment.outer", -- annotation
                            ["ic"] = "@comment.outer",
                            ["ab"] = "@block.outer", -- for md files
                            ["ib"] = "@block.inner",
                        },
                    },
                },
            })
        end,
    },
}
