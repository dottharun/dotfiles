return {
    "chottolabs/kznllm.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
    },
    config = function(self)
        local kznllm = require("kznllm")
        local spec = require("kznllm.specs.openai")

        kznllm.TEMPLATE_DIRECTORY = vim.fn.expand(self.dir) .. "/templates/"
        -- fallsback to a preset default model configuration

        local function groq_llm()
            kznllm.invoke_llm({
                { role = "system", prompt_template = spec.PROMPT_TEMPLATES.GROQ.FILL_MODE_SYSTEM_PROMPT },
                { role = "user", prompt_template = spec.PROMPT_TEMPLATES.GROQ.FILL_MODE_USER_PROMPT },
            }, spec.make_job)
        end

        vim.keymap.set({ "n", "v" }, "<leader>zq", groq_llm, { desc = "Send current selection to LLM groq_llm" })
        vim.keymap.set({ "n", "v" }, "<C-q>", groq_llm, { desc = "Send current selection to LLM groq_llm" })

        -- openrouter nous hermes
        spec.SELECTED_MODEL = { name = "nousresearch/hermes-3-llama-3.1-405b" }
        spec.API_KEY_NAME = "OPEN_ROUTER_API_KEY"
        spec.URL = "https://openrouter.ai/api/v1/chat/completions"

        local function hermes_fill()
            kznllm.invoke_llm({
                { role = "system", prompt_template = spec.PROMPT_TEMPLATES.NOUS_RESEARCH.FILL_MODE_SYSTEM_PROMPT },
                { role = "user", prompt_template = spec.PROMPT_TEMPLATES.NOUS_RESEARCH.FILL_MODE_USER_PROMPT },
            }, spec.make_job)
        end

        vim.keymap.set({ "n", "v" }, "<leader>zh", hermes_fill, { desc = "Send current selection to LLM hermes_fill" })
        vim.keymap.set({ "n", "v" }, "<C-h>", hermes_fill, { desc = "Send current selection to LLM hermes_fill" })
    end,
}
