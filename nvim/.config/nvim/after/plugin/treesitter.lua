require("nvim-treesitter.configs").setup({
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = {
        "html",
        "css",
        "json",
        "jsonc",
        "javascript",
        "typescript",
        "c",
        "cpp",
        "go",
        "rust",
        "lua",
        "vim",
        "vimdoc",
        "query",
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    auto_install = true,

    highlight = {
        enable = true,
        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- list of language that will be disabled
        disable = { "latex" },

        additional_vim_regex_highlighting = false,
    },
})


--highlight chunk like indent blank line
require("hlchunk").setup({
    chunk = {
        chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "╭",
            left_bottom = "╰",
            right_arrow = ">",
        },
    },
    indent = { enable = false, },
    line_num = { enable = false, },
    blank = { enable = false, },
})
