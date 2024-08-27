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

        local function llm_fill()
            kznllm.invoke_llm({
                { role = "system", prompt_template = spec.PROMPT_TEMPLATES.GROQ.FILL_MODE_SYSTEM_PROMPT },
                { role = "user", prompt_template = spec.PROMPT_TEMPLATES.GROQ.FILL_MODE_USER_PROMPT },
            }, spec.make_job)
        end

        vim.keymap.set({ "n", "v" }, "<leader>zq", llm_fill, { desc = "Send current selection to LLM llm_fill" })
        vim.keymap.set({ "n", "v" }, "<C-q>", llm_fill, { desc = "Send current selection to LLM llm_fill" })
    end,
}
