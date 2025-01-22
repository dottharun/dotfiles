return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",

        --pretty ts errs
        "davidosomething/format-ts-errors.nvim",
    },

    config = function()
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        local lspconfig = require("lspconfig")

        -- -- Set up lspconfig for all filetypes except Java
        -- lspconfig.util.on_setup = function(config)
        --     if config.filetypes and vim.tbl_contains(config.filetypes, "java") then
        --         -- Skip setup for Java files
        --         return
        --     end
        --     -- Proceed with normal setup for other filetypes
        --     lspconfig[config.name].setup(config)
        -- end

        -- lspconfig.clangd.setup({
        --     cmd = {
        --         "clangd",
        --         "--header-insertion=never",
        --         "--background-index=false",
        --         "--pch-storage=memory",
        --         "--limit-results=10",
        --         "--clang-tidy=false",
        --         "--completion-style=detailed",
        --         "--malloc-trim",
        --         "--suggest-missing-includes=false",
        --         "--cross-file-rename=false",
        --         "--all-scopes-completion=false",
        --         -- "--log=verbose", -- for debugging
        --     },
        -- })

        -- lspconfig.clangd.setup({
        --     cmd = {
        --         "clangd",
        --         "--offset-encoding=utf-16",
        --         "--background-index",
        --         "--malloc-trim",
        --         "--suggest-missing-includes=false",
        --         "--header-insertion=never",
        --         "--completion-style=bundled",
        --         "--limit-references=0",
        --         "--limit-results=0",
        --         "-j=8",
        --     },
        -- })

        lspconfig.ccls.setup({})

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "gopls",
                "tsserver",
                "pyright",
                "rust_analyzer",
            },

            handlers = {
                bashls = function()
                    lspconfig.bashls.setup({})
                end,
                pyright = function()
                    lspconfig.pyright.setup({})
                end,
                lua_ls = function()
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                },
                            },
                        },
                    })
                end,
                gopls = function()
                    lspconfig.gopls.setup({
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
                    lspconfig.tsserver.setup({
                        --for manual startup in js files
                        -- autostart = false,

                        on_init = function(client)
                            -- for prettierd to work - turn off format from tsserver
                            client.server_capabilities.documentFormattingProvider = false
                            client.server_capabilities.documentFormattingRangeProvider = false
                        end,
                        init_options = { preferences = { disableSuggestions = true } },

                        settings = {
                            maxTsServerMemory = 8192,
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

                        -- pretty ts errs
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
                    })
                end,
            },
        })

        -- -- controlling lsp -- maybe i dont need it
        -- vim.keymap.set("n", "<leader>vrs", "<cmd>LspRestart<CR><Esc>")
        -- vim.keymap.set("n", "<leader>vv", "<cmd>LspStart<CR><Esc>")
        -- vim.keymap.set("n", "<leader>vk", "<cmd>LspStop<CR><Esc>")
        -- vim.keymap.set("n", "<leader>vi", "<cmd>LspInfo<CR><Esc>")
    end,
}
