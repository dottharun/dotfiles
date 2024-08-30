-- browser embed nvim
return {
    "glacambre/firenvim",
    build = ":call firenvim#install(0)",
    config = function()
        vim.g.firenvim_config = {
            localSettings = {
                [".*"] = {
                    cmdline = "neovim", -- have nvim cmdline
                },
            },
        }

        if vim.g.started_by_firenvim == true then
            -- TODO: This is a hack to get around nix messing with env vars - resove this or remove nix
            vim.fn.setenv("LD_LIBRARY_PATH", "")

            vim.o.guifont = "Source Code Pro:h14"
            vim.o.laststatus = 0 -- to stop showing status lines

            -- to go back to website
            vim.api.nvim_set_keymap("n", "<Esc><Esc>", "<Cmd>call firenvim#focus_page()<CR>", {})

            -- website specific commands
            vim.api.nvim_create_autocmd({ "BufEnter" }, {
                pattern = "github.com_*.txt",
                command = "set filetype=markdown",
            })

            vim.api.nvim_create_autocmd({ "BufEnter" }, {
                pattern = { "www.hackerrank.com_*.txt", "leetcode.com_*.txt" },
                command = "set ft=cpp",
            })
        end
    end,
}
