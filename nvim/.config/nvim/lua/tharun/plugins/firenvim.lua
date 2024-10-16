-- browser embed nvim
return {
    "glacambre/firenvim",
    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    lazy = not vim.g.started_by_firenvim,
    build = ":call firenvim#install(0)",
    config = function()
        vim.g.firenvim_config = {
            localSettings = {
                [".*"] = {
                    cmdline = "neovim", -- have nvim cmdline
                    takeover = "never",
                    priority = 0,
                },
                -- stylua: ignore start
                ["(https://web.whatsapp.com/"
                    .. "|https://www.twitch.tv/"
                    .. "|https://discord.com/"
                    .. "|https://x.com/"
                    .. "|https://styled-components.com/"
                    .. "|https://codepen.io/"
                    .. "|https://docs.google.com/"
                    ..")"] = {
                    takeover = "never",
                    priority = 1,
                },
                -- stylua: ignore end
            },
        }

        if vim.g.started_by_firenvim == true then
            -- TODO: This is a hack to get around nix messing with env vars - resove this or remove nix
            vim.fn.setenv("LD_LIBRARY_PATH", "")

            vim.o.guifont = "Source Code Pro:h14"
            vim.o.laststatus = 0 -- to stop showing status lines

            -- Hack to set the min-lines in loop - since browser resizes in all the time
            local timer = vim.uv.new_timer()
            timer:start(
                0,
                500,
                vim.schedule_wrap(function()
                    if vim.o.lines < 6 then
                        vim.o.lines = 6
                    end

                    if vim.o.columns < 40 then
                        vim.o.columns = 40
                    end
                end)
            )

            -- to go back to website
            vim.keymap.set("n", "<Esc>", "<Cmd>call firenvim#focus_page()<CR>", {})
            -- hide firenvim
            vim.keymap.set("n", "<C-z>", "<Cmd>call firenvim#hide_frame()<CR>", {})
            -- send chat+enter to browser
            vim.keymap.set(
                "n",
                "<leader><CR>",
                vim.schedule_wrap(function()
                    -- print("pressing enter key")
                    vim.cmd([[
                    silent write
                    call firenvim#press_keys('<CR>')
                    ]])
                    vim.api.nvim_feedkeys("ggdG", "n", false)
                end),
                {}
            )

            -- website specific commands
            vim.api.nvim_create_autocmd({ "BufEnter" }, {
                pattern = "github.com_*.txt",
                command = "set filetype=markdown",
            })

            vim.api.nvim_create_autocmd({ "BufEnter" }, {
                pattern = { "www.hackerrank.com_*.txt", "leetcode.com_*.txt", "app.codesignal.com_*.txt" },
                command = "set ft=cpp",
            })
            vim.api.nvim_create_autocmd({ "BufEnter" }, {
                pattern = { "app.codesignal.com_*.txt", "leetcode.com_*.txt" },
                command = "hi clear | colorscheme visual_studio_code",
            })
            vim.api.nvim_create_autocmd({ "BufEnter" }, {
                pattern = { "www.hackerrank.com_*.txt" },
                command = "hi clear | colorscheme hacker-dark",
            })
        end
    end,
}
