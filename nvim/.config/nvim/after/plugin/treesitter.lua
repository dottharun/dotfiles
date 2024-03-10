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

require'treesitter-context'.setup{
  max_lines = 10, -- How many lines the window should span. Values <= 0 mean no limit.
}


--highlight chunk like indent blank line
require("hlchunk").setup({
    chunk = {
        enable = false,    --breaking all the time
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

if vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] == 0 then
    vim.cmd([[DisableHL]])
end

-- require("ibl").setup({
--     indent = { char = "▏" },
--     scope = { enabled = false },
-- })
