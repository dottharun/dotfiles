require("tharun")
-- print("hello")

local augroup = vim.api.nvim_create_augroup
local AutoRemoveTrailingWhiteSpaceGroup = augroup('whiteSpace', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})
autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({ "BufWritePre" }, {
    group = AutoRemoveTrailingWhiteSpaceGroup,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

-- FORMATTER PRETTIER
local formatter_prettier = {
    function()
        -- print("hello from prettierd")
        return {
            -- exe = "prettier",
            -- args = {
            --   "--stdin-filepath",
            --   vim.api.nvim_buf_get_name(0)
            -- },
            -- stdin = true,
            exe = "prettierd",
            args = { vim.api.nvim_buf_get_name(0) },
            stdin = true
        }
    end
}

require('formatter').setup({
    logging = false,
    filetype = {
        javascript = formatter_prettier,
        javascriptreact = formatter_prettier,
        typescript = formatter_prettier,
        typescriptreact = formatter_prettier,
        json = formatter_prettier,
        graphql = formatter_prettier
    }
})

vim.api.nvim_exec([[
augroup FormatAutogroup
autocmd!
autocmd BufWritePost *.astro,*.ts,*.tsx,*.mjs,*.js,*.jsx,*.json,*.graphql FormatWrite
augroup END
]], true)

-- think i no need this since this is done in lsp-zero
vim.api.nvim_command("autocmd BufWritePre *.ex,*.go lua vim.lsp.buf.format()")
