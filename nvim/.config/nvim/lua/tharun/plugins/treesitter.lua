return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local ts = require("nvim-treesitter")
            ts.setup()
            ts.install({
                "html",
                "css",
                "json",
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
                "markdown",
                "markdown_inline",
            })

            local disabled_ft = {
                latex = true,
                tex = true,
                csv = true,
                swift = true,
            }

            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    local ft = vim.bo[args.buf].filetype
                    if disabled_ft[ft] then
                        return
                    end
                    if pcall(vim.treesitter.start, args.buf) then
                        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                        if ft == "markdown" then
                            vim.bo[args.buf].syntax = "ON"
                        end
                    end
                end,
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
        branch = "main",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("nvim-treesitter-textobjects").setup({
                select = {
                    lookahead = true,
                },
            })

            local select = require("nvim-treesitter-textobjects.select")
            local keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["aC"] = "@class.outer",
                ["iC"] = "@class.inner",
                ["ac"] = "@comment.outer", -- annotation
                ["ic"] = "@comment.outer",
                ["ab"] = "@block.outer", -- for md files
                ["ib"] = "@block.inner",
            }
            for lhs, query in pairs(keymaps) do
                vim.keymap.set({ "x", "o" }, lhs, function()
                    select.select_textobject(query, "textobjects")
                end)
            end
        end,
    },
}
