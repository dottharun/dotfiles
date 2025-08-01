-- print("hello from autocmd")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local trailing_group = augroup("trailingWhiteSpace", {})
local yank_group = augroup("HighlightYank", {})
local lsp_group = augroup("MyLSP", {})
local gitignore_group = augroup("GitIgnoreCheck", {})

local function is_buffer_gitignored(buffer_number)
    local file_path = vim.api.nvim_buf_get_name(buffer_number)
    local obj = vim.system({ "git", "check-ignore", file_path, "-q" }, { text = true }):wait()
    -- print("obj: ", vim.inspect(obj))
    return obj.code == 0
end

autocmd("BufReadPost", {
    group = gitignore_group,
    callback = function(e)
        if is_buffer_gitignored(e.buf) then
            vim.bo.readonly = true
            print("File is git-ignored and opened in read-only mode")
        end
    end,
})

autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})

autocmd({ "BufWritePre" }, {
    group = trailing_group,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

autocmd("LspAttach", {
    group = lsp_group,
    callback = function(e)
        local opts = { buffer = e.buf }
        -- vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)   --shows nodemodules in quickfix

        vim.keymap.set("n", "gR", function()
            vim.lsp.buf.references()
        end, opts)

        vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
        vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
        vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        -- vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)   --going to quickfix list which i dont like

        vim.keymap.set("n", "K", function()
            vim.lsp.buf.hover()
        end, opts)
        vim.keymap.set("n", "[d", function()
            vim.diagnostic.goto_next()
        end, opts)
        vim.keymap.set("n", "]d", function()
            vim.diagnostic.goto_prev()
        end, opts)

        -- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vss", "<cmd>Telescope lsp_workspace_symbols<CR>", opts)
        vim.keymap.set("n", "<leader>vsd", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", opts)
        vim.keymap.set("n", "gs", "<cmd>Telescope lsp_workspace_symbols<CR>", opts)
        vim.keymap.set("n", "gy", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", opts)
        vim.keymap.set("n", "gw", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", opts)

        vim.keymap.set("n", "<leader>vd", function()
            vim.diagnostic.open_float()
        end, opts)
        vim.keymap.set("n", "<leader>vca", function()
            vim.lsp.buf.code_action()
        end, opts)
        vim.keymap.set("n", "<leader>vrr", function()
            vim.lsp.buf.references()
        end, opts)
        vim.keymap.set("n", "<leader>vrn", function()
            vim.lsp.buf.rename()
        end, opts)
        -- TODO: find if this even works
        vim.keymap.set("i", "<C-p>", function()
            vim.lsp.buf.signature_help()
        end, opts)

        vim.keymap.set("n", "<leader>vh", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, opts)
    end,
})
