return {
    "chottolabs/kznllm.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "chottolabs/plenary.nvim" }, -- patched to resolve symlinked directories
    },
    dev = true,
    config = function(self)
        local presets = require("kznllm.presets")

        vim.keymap.set({ "n", "v" }, "<leader>zs", presets.switch_presets, { desc = "switch between presets" })

        local function llm_fill()
            local spec, preset = presets.load()
            presets.invoke_llm(
                preset.make_data_fn,
                spec.make_curl_args,
                spec.make_job,
                vim.tbl_extend("keep", preset.opts, {})
            )
        end

        vim.keymap.set({ "n", "v" }, "<leader>zz", llm_fill, { desc = "Send current selection to LLM llm_fill" })

        -- optional for debugging purposes
        local function debug()
            local spec, preset = presets.load()
            presets.invoke_llm(
                preset.make_data_fn,
                spec.make_curl_args,
                spec.make_job,
                vim.tbl_extend("keep", preset.opts, { debug = true })
            )
        end

        vim.keymap.set({ "n", "v" }, "<leader>zd", debug, { desc = "Send current selection to LLM debug" })

        vim.api.nvim_set_keymap("n", "<Esc>", "", {
            noremap = true,
            silent = true,
            callback = function()
                vim.api.nvim_exec_autocmds("User", { pattern = "LLM_Escape" })
            end,
        })

        local kznllm = require("kznllm")
        local Path = require("plenary.path")

        local TEMPLATE_DIRECTORY = Path:new(vim.fn.expand(self.dir) .. "/templates")

        ---Example implementation of a `make_data_fn` compatible with `kznllm.invoke_llm` for groq spec
        ---@param prompt_args any
        ---@param opts { model: string, temperature: number, template_directory: Path, debug: boolean }
        ---@return table
        ---
        local function make_data_for_hermes_chat(prompt_args, opts)
            return {
                messages = {
                    {
                        role = "system",
                        content = kznllm.make_prompt_from_template(
                            opts.template_directory / "nous_research/fill_mode_system_prompt.xml.jinja",
                            prompt_args
                        ),
                    },
                    {
                        role = "user",
                        content = kznllm.make_prompt_from_template(
                            opts.template_directory / "nous_research/fill_mode_user_prompt.xml.jinja",
                            prompt_args
                        ),
                    },
                },
                model = opts.model,
                temperature = opts.temperature,
                stream = true,
            }
        end

        -- set initial preset on load
        local spec = require("kznllm.specs.openai")

        -- spec.SELECTED_MODEL = { name = "nousresearch/hermes-3-llama-3.1-405b" }
        -- spec.API_KEY_NAME = "OPEN_ROUTER_API_KEY"
        -- spec.URL = "https://openrouter.ai/api/v1/chat/completions"

        local function hermes_fill()
            presets.invoke_llm(make_data_for_hermes_chat, spec.make_curl_args, spec.make_job, {
                model = "meta-llama/llama-3.1-405b-instruct:free",
                max_tokens = 8192,
                temperature = 0.7,
                base_url = "https://openrouter.ai",
                endpoint = "/api/v1/chat/completions",
                template_directory = TEMPLATE_DIRECTORY,
                api_key_name = "OPENROUTER_API_KEY",
                debug = true,
            })
        end

        vim.keymap.set({ "n", "v" }, "<leader>zh", hermes_fill, { desc = "Send current selection to LLM hermes_fill" })
    end,
}
