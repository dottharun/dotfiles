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

-- --
-- --
-- -- auto buffer close
--
-- local max_buffers = 10 -- Set your desired max number of buffers
--
-- local function close_unmodified_buffers_except_current()
--   local current_buffer = vim.api.nvim_get_current_buf()
--   local buffers = vim.api.nvim_list_bufs()
--
--   for _, buf in ipairs(buffers) do
--     local is_modified = vim.api.nvim_buf_get_option(buf, "modified")
--     if buf ~= current_buffer and not is_modified then
--       if vim.fn.buflisted(buf) == 1 then
--         -- Attempt to delete the buffer without forcing, close windows if the buffer is no longer displayed anywhere
--         vim.cmd('bdelete ' .. buf)
--         return -- Exit after closing one buffer to not exceed the max buffer limit by more than one
--       end
--     end
--   end
-- end
--
-- local function check_and_close_buffers()
--   local buffer_count = vim.fn.len(vim.fn.getbufinfo({buflisted = 1}))
--   if buffer_count > max_buffers then
--     print("Buffer limit exceeded. Closing an unmodified buffer...")
--     close_unmodified_buffers_except_current()
--   end
-- end
--
-- -- Create or get an autocommand group
-- local LimBufGrp = augroup( "TharunLimitBuffersGroup", { clear = true })
--
-- -- Set up an autocommand within the group
-- vim.api.nvim_create_autocmd("BufAdd", {
--   group = LimBufGrp,
--   callback = function()
--     check_and_close_buffers()
--   end,
-- })
--
