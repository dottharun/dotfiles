local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }
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
    vim.keymap.set("n", "<CR><CR>", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", opts)

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
    vim.keymap.set("i", "<C-p>", function()
        vim.lsp.buf.signature_help()
    end, opts)
end)

-- controlling lsp
vim.keymap.set("n", "<leader>vrs", "<cmd>LspRestart<CR><Esc>")
vim.keymap.set("n", "<leader>vv", "<cmd>LspStart<CR><Esc>")
vim.keymap.set("n", "<leader>vk", "<cmd>LspStop<CR><Esc>")
vim.keymap.set("n", "<leader>vi", "<cmd>LspInfo<CR><Esc>")

require("lspconfig").clangd.setup({})

local ih = require("inlay-hints")

require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "gopls",
        "texlab",
        "tsserver",
        "eslint",
        "nil_ls",
        "pyright",
        "rust_analyzer",
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
                            library = { vim.fn.expand("$VIMRUNTIME/lua") },
                        },
                    },
                },
            })

            require("lspconfig").lua_ls.setup(lua_opts)
        end,
        texlab = function()
            require("lspconfig").texlab.setup({})
        end,
        pyright = function()
            require("lspconfig").pyright.setup({})
        end,
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
                --for manual startup in js files
                autostart = false,

                on_init = function(client)
                    -- for prettierd to work
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentFormattingRangeProvider = false
                end,
                init_options = { preferences = { disableSuggestions = true } },

                -- pretty ts err
                handlers = {
                    ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
                        if result.diagnostics == nil then
                            return
                        end

                        -- ignore some tsserver diagnostics
                        local idx = 1
                        while idx <= #result.diagnostics do
                            local entry = result.diagnostics[idx]

                            local formatter = require("format-ts-errors")[entry.code]
                            entry.message = formatter and formatter(entry.message) or entry.message

                            -- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
                            if entry.code == 80001 then
                                -- { message = "File is a CommonJS module; it may be converted to an ES module.", }
                                table.remove(result.diagnostics, idx)
                            else
                                idx = idx + 1
                            end
                        end

                        vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
                    end,
                },

                -- for inlay hints
                on_attach = function(client, bufnr)
                    print("help me inlayhints")
                    -- ih.on_attach(client, bufnr)

                    -- twoslash comment plugin
                    require("twoslash-queries").attach(client, bufnr)
                    -- prettier breaks this might need something
                    vim.keymap.set("n", "gkk", "<cmd>TwoslashQueriesInspect<CR>", { remap = false })
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
        eslint = function()
            require("lspconfig").eslint.setup({
                --for manual startup in js files
                autostart = false,
            })
        end,
        nil_ls = function()
            require("lspconfig").nil_ls.setup({
                on_init = function(client)
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentFormattingRangeProvider = false
                end,
            })
        end,
    },
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    sources = {
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
    },
    formatting = lsp_zero.cmp_format(),
    mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),
})
