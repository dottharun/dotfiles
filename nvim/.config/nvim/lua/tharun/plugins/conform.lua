return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" }, --TODO: needs a write to disable - fix it by using some other event
    config = function()
        require("conform").setup({
            -- configuring formatters
            formatters = {
                ["clang-format"] = {
                    args = {
                        "--fallback-style=none", --don't format when there is no .clang-format file
                        "-assume-filename",
                        "$FILENAME",
                    },
                },
            },

            -- setting formatters only
            formatters_by_ft = {
                lua = { "stylua" },
                cpp = { "clang-format" },
                c = { "clang-format" },
                go = { "gofmt" },
                java = { lsp_format = "prefer" },
                python = { "black" },

                javascript = { "prettierd", "prettier", stop_after_first = true },
                javascriptreact = { "prettierd", "prettier", stop_after_first = true },
                typescript = { "prettierd", "prettier", stop_after_first = true },
                typescriptreact = { "prettierd", "prettier", stop_after_first = true },
                json = { "prettierd", "prettier", stop_after_first = true },
                html = { "prettierd", "prettier", stop_after_first = true },
                css = { "prettierd", "prettier", stop_after_first = true },
            },
        })

        vim.api.nvim_create_user_command("ConformDisable", function(args)
            if args.bang then
                -- FormatDisable! will disable formatting just for this buffer
                vim.b.disable_autoformat = true
            else
                vim.g.disable_autoformat = true
            end
        end, {
            desc = "Disable autoformat-on-save",
            bang = true,
        })
        vim.api.nvim_create_user_command("ConformEnable", function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end, {
            desc = "Re-enable autoformat-on-save",
        })

        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function(args)
                -- Disable autoformat on certain filetypes
                local ignore_filetypes = { "sql", "json" }
                if vim.tbl_contains(ignore_filetypes, vim.bo[args.buf].filetype) then
                    return
                end

                -- Disable with a global or buffer-local variable
                if vim.g.disable_autoformat or vim.b[args.buf].disable_autoformat then
                    return
                end

                -- Disable autoformat for files in a certain path
                local bufname = vim.api.nvim_buf_get_name(args.buf)
                if bufname:match("/node_modules/") then
                    return
                end

                require("conform").format({ bufnr = args.buf, timeout_ms = 5000, lsp_format = "fallback" })
            end,
        })
    end,
}
