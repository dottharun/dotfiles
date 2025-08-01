return {
    "mfussenegger/nvim-jdtls",
    dependencies = {
        "williamboman/mason.nvim",

        -- for debugger
        "mfussenegger/nvim-dap",
    },
    ft = { "java" },
    -- TODO: cleanup and restructure the whole file, remove redundant and silly hacks
    config = function()
        local java_cmds = vim.api.nvim_create_augroup("java_cmds", { clear = true })
        local home = os.getenv("HOME")
        local java_home = os.getenv("JAVA_HOME")
        local cache_vars = {}

        local root_files = {
            "settings.gradle",
            "settings.gradle.kts",
            "pom.xml",
            "build.gradle",
            "mvnw",
            "gradlew",
            "build.gradle",
            "build.gradle.kts",
            ".git",
        }

        local features = {
            -- change this to `true` to enable codelens
            -- codelens = true,

            -- change this to `true` if you have `nvim-dap`,
            -- `java-test` and `java-debug-adapter` installed
            debugger = true,
        }

        local function get_jdtls_paths()
            if cache_vars.paths then
                return cache_vars.paths
            end

            local path = {}
            path.data_dir = vim.fn.stdpath("cache") .. "/nvim-jdtls"

            local jdtls_install = home .. "/.local/share/jdtls"

            -- path.java_agent = jdtls_install .. "/lombok.jar"

            path.launcher_jar = vim.fn.glob(jdtls_install .. "/plugins/org.eclipse.equinox.launcher_*.jar")

            if vim.fn.has("mac") == 1 then
                path.platform_config = jdtls_install .. "/config_mac"
            elseif vim.fn.has("unix") == 1 then
                path.platform_config = jdtls_install .. "/config_linux"
            elseif vim.fn.has("win32") == 1 then
                path.platform_config = jdtls_install .. "/config_win"
            end

            path.bundles = {}

            -- ---
            -- -- Include java-test bundle if present
            -- ---
            -- local java_test_path = require("mason-registry").get_package("java-test"):get_install_path()
            --
            -- local java_test_bundle = vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar"), "\n")
            --
            -- if java_test_bundle[1] ~= "" then
            --     vim.list_extend(path.bundles, java_test_bundle)
            -- end

            ---
            -- Include java-debug-adapter bundle if present
            ---
            local java_debug_path = require("mason-registry").get_package("java-debug-adapter"):get_install_path()

            local java_debug_bundle = vim.split(
                vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"),
                "\n"
            )

            if java_debug_bundle[1] ~= "" then
                vim.list_extend(path.bundles, java_debug_bundle)
            end

            ---
            -- Useful if you're starting jdtls with a Java version that's
            -- different from the one the project uses.
            ---
            path.runtimes = {
                -- Note: the field `name` must be a valid `ExecutionEnvironment`,
                -- you can find the list here:
                -- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
                --
                -- This example assume you are using sdkman: https://sdkman.io
                {
                    name = "JavaSE-24",
                    path = vim.fn.expand("~/.sdkman/candidates/java/24.0.1-tem"),
                },
                {
                    name = "JavaSE-23",
                    path = vim.fn.expand("~/.sdkman/candidates/java/23.0.1-tem"),
                },
                {
                    name = "JavaSE-21",
                    path = vim.fn.expand("~/.sdkman/candidates/java/21.0.5-tem"),
                },
            }

            cache_vars.paths = path

            return path
        end

        local function enable_codelens(bufnr)
            pcall(vim.lsp.codelens.refresh)

            vim.api.nvim_create_autocmd("BufWritePost", {
                buffer = bufnr,
                group = java_cmds,
                desc = "refresh codelens",
                callback = function()
                    pcall(vim.lsp.codelens.refresh)
                end,
            })
        end

        local function enable_debugger(bufnr)
            -- require("jdtls").setup_dap({ hotcodereplace = "auto" })
            require("jdtls.dap").setup_dap_main_class_configs()

            -- vim.keymap.set(
            --     "n",
            --     "<leader>df",
            --     "<cmd>lua require('jdtls').test_class()<cr>",
            --     { buffer = bufnr, desc = "debug test class" }
            -- )
            -- vim.keymap.set(
            --     "n",
            --     "<leader>dn",
            --     "<cmd>lua require('jdtls').test_nearest_method()<cr>",
            --     { buffer = bufnr, desc = "debug nearest test method" }
            -- )
        end

        local function jdtls_on_attach(client, bufnr)
            -- enable inlay hint by default for java
            -- vim.lsp.inlay_hint.enable(true, { bufnr })

            -- to turn off semantic tokens for java only -- raw treesitter seems better
            client.server_capabilities.semanticTokensProvider = nil

            if features.debugger then
                enable_debugger(bufnr)
            end

            if features.codelens then
                enable_codelens(bufnr)
            end

            -- The following mappings are based on the suggested usage of nvim-jdtls
            -- https://github.com/mfussenegger/nvim-jdtls#usage
            -- -- cr => code/cut refactor

            local opts = { buffer = bufnr }
            vim.keymap.set("n", "cro", "<cmd>lua require('jdtls').organize_imports()<cr>", opts)
            vim.keymap.set("n", "crv", "<cmd>lua require('jdtls').extract_variable()<cr>", opts)
            vim.keymap.set("x", "crv", "<esc><cmd>lua require('jdtls').extract_variable(true)<cr>", opts)
            vim.keymap.set("n", "crc", "<cmd>lua require('jdtls').extract_constant()<cr>", opts)
            vim.keymap.set("x", "crc", "<esc><cmd>lua require('jdtls').extract_constant(true)<cr>", opts)
            vim.keymap.set("x", "crm", "<esc><Cmd>lua require('jdtls').extract_method(true)<cr>", opts)
            -- to print java bytecode with javap - print-java-p
            vim.keymap.set("n", "<leader>pjp", "<cmd>lua require('jdtls').javap()<cr>", opts)
        end

        local function jdtls_setup(_)
            local jdtls = require("jdtls")
            local extendedClientCapabilities = jdtls.extendedClientCapabilities
            extendedClientCapabilities.onCompletionItemSelectedCommand = "editor.action.triggerParameterHints"

            local path = get_jdtls_paths()
            local data_dir = path.data_dir .. "/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

            if cache_vars.capabilities == nil then
                jdtls.extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

                local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
                cache_vars.capabilities = vim.tbl_deep_extend(
                    "force",
                    vim.lsp.protocol.make_client_capabilities(),
                    ok_cmp and cmp_lsp.default_capabilities() or {}
                )
            end

            -- The command that starts the language server
            -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
            local cmd = {
                -- TODO: should work without manually setting the path - try adding JAVA_HOME, path to .profile file
                java_home .. "/bin/java",
                -- "java",

                "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                "-Dosgi.bundles.defaultStartLevel=4",
                "-Declipse.product=org.eclipse.jdt.ls.core.product",
                "-Dlog.protocol=true",
                "-Dlog.level=ALL",
                -- "-javaagent:" .. path.java_agent,
                "-Xms1g",
                "--add-modules=ALL-SYSTEM",
                "--add-opens",
                "java.base/java.util=ALL-UNNAMED",
                "--add-opens",
                "java.base/java.lang=ALL-UNNAMED",

                -- 💀
                "-jar",
                path.launcher_jar,

                -- 💀
                "-configuration",
                path.platform_config,

                -- 💀
                "-data",
                data_dir,
            }

            local lsp_settings = {
                java = {
                    -- jdt = {
                    --   ls = {
                    --     vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G -Xms100m"
                    --   }
                    -- },
                    project = {
                        referencedLibraries = {
                            -- add any library jars here for the lsp to pick them up
                        },
                        -- for the main source path for the java package management
                        -- TODO: might fail in maven/gradle -- needs research
                        sourcePaths = { "src", "", "src/main/java" },
                    },
                    eclipse = {
                        downloadSources = true,
                    },
                    configuration = {
                        updateBuildConfiguration = "interactive",
                        runtimes = path.runtimes,
                    },
                    maven = {
                        downloadSources = true,
                    },
                    implementationsCodeLens = {
                        enabled = true,
                    },
                    referencesCodeLens = {
                        enabled = true,
                    },
                    references = {
                        includeDecompiledSources = true,
                    },
                    inlayHints = {
                        enabled = true,
                        parameterNames = {
                            enabled = "all", -- literals, all, none
                        },
                    },
                    format = {
                        enabled = true,
                        settings = {
                            url = home .. "/dotfiles/nvim/.config/nvim/lsp/tharun_new.xml",
                        },
                    },
                },
                signatureHelp = {
                    enabled = true,
                },
                completion = {
                    favoriteStaticMembers = {
                        "org.hamcrest.MatcherAssert.assertThat",
                        "org.hamcrest.Matchers.*",
                        "org.hamcrest.CoreMatchers.*",
                        "org.junit.jupiter.api.Assertions.*",
                        "java.util.Objects.requireNonNull",
                        "java.util.Objects.requireNonNullElse",
                        "org.mockito.Mockito.*",
                    },
                },
                contentProvider = {
                    preferred = "fernflower",
                },
                extendedClientCapabilities = jdtls.extendedClientCapabilities,
                sources = {
                    organizeImports = {
                        starThreshold = 9999,
                        staticStarThreshold = 9999,
                    },
                },
                codeGeneration = {
                    toString = {
                        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                    },
                    useBlocks = true,
                },
            }

            -- This starts a new client & server,
            -- or attaches to an existing client & server depending on the `root_dir`.
            jdtls.start_or_attach({
                cmd = cmd,
                settings = lsp_settings,
                on_attach = jdtls_on_attach,
                capabilities = cache_vars.capabilities,
                root_dir = vim.fs.root(0, root_files),
                flags = {
                    allow_incremental_sync = true,
                },
                init_options = {
                    bundles = path.bundles,
                    extendedClientCapabilities = extendedClientCapabilities,
                },
            })
        end

        --TODO: hack to enfore the formatting by the formatter
        vim.opt.tabstop = 2
        vim.opt.softtabstop = 2
        vim.opt.shiftwidth = 2

        vim.api.nvim_create_autocmd("FileType", {
            group = java_cmds,
            pattern = { "java" },
            desc = "Setup jdtls",
            callback = jdtls_setup,
        })
    end,
}
