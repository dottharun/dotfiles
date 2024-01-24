local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    -- print("help me lsp, client: ", client)
    lsp_zero.buffer_autoformat()

    local opts = { buffer = bufnr, remap = false }
    -- vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gd", '<cmd>Telescope lsp_definitions<CR>', opts)
    vim.keymap.set("n", "gr", '<cmd>Telescope lsp_references<CR>', opts)

    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>lws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>ld", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>lca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>lrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>lrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    -- controlling lsp
    vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart<CR><Esc>", opts)
    vim.keymap.set("n", "<leader>ls", "<cmd>LspStart<CR><Esc>", opts)
    vim.keymap.set("n", "<leader>lk", "<cmd>LspStop<CR><Esc>", opts)
end)

local ih = require("inlay-hints")

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'lua_ls',
        'gopls',
        'texlab',
        'tsserver',
        'eslint',
        'clangd',
        'pyright',
        'rust_analyzer',
    },

    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            --setting our custom option here
            --may need to move this to another new lsp folder
            local lua_opts = lsp_zero.nvim_lua_ls({
                settings = {
                    Lua = {
                        workspace = {
                            checkThirdParty = false,
                            library = { vim.fn.expand("$VIMRUNTIME/lua"), },
                        },
                    }
                },
            })

            require("lspconfig").lua_ls.setup(lua_opts)
        end,
        texlab = function() require("lspconfig").texlab.setup({}) end,
        pyright = function() require("lspconfig").pyright.setup({}) end,
        gopls = function()
            require("lspconfig").gopls.setup({
                on_attach = function(c, b)
                    print("help me inlayhints")
                    ih.on_attach(c, b)
                end,
                settings = {
                    gopls = {
                        hints = {
                            assignVariableTypes = true,
                            compositeLiteralFields = true,
                            compositeLiteralTypes = true,
                            constantValues = true,
                            functionTypeParameters = true,
                            parameterNames = true,
                            rangeVariableTypes = true,
                        },
                    },
                },
            })
        end,
        tsserver = function()
            require("lspconfig").tsserver.setup({
                on_init = function(client)
                    -- for prettierd to work
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentFormattingRangeProvider = false
                end,
                init_options = { preferences = { disableSuggestions = true } },

                -- for inlay hints
                on_attach = function(c, b)
                    print("help me inlayhints")
                    ih.on_attach(c, b)
                end,
                settings = {
                    javascript = {
                        inlayHints = {
                            includeInlayEnumMemberValueHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayVariableTypeHints = true,
                        },
                    },
                    typescript = {
                        inlayHints = {
                            includeInlayEnumMemberValueHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayVariableTypeHints = true,
                        },
                    },
                },
            })
        end,
        eslint = function() require('lspconfig').eslint.setup({}) end
    },
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
    },
    formatting = lsp_zero.cmp_format(),
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        -- ["<Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.confirm({ select = true })
        --     else
        --         fallback()
        --     end
        -- end, { "i", "s" }),
        ['<C-Space>'] = cmp.mapping.complete(),
        -- ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
        -- ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select)
    }),
})
