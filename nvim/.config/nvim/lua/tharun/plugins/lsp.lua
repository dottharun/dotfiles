return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",

        --pretty ts errs
        "davidosomething/format-ts-errors.nvim",
    },

    config = function()
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require("lspconfig").clangd.setup({
            cmd = {
                "clangd",
                "-header-insertion=never",
                -- "--log=verbose", -- for debugging
            },
        })

        require("fidget").setup({})
        require("mason").setup()
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
                lua_ls = function()
                    local lspconfig = require("lspconfig")
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
                    require("lspconfig").gopls.setup({
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

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" }, -- For luasnip users.
            }, {
                { name = "buffer" },
            }),
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end,
}
