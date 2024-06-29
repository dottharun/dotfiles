return {
	"melbaldove/llm.nvim",
	dependencies = { "nvim-neotest/nvim-nio", "nvim-lua/plenary.nvim" },
	dev = true,
	config = function()
		-- Manually configure the services
		-- conversion
		-- local system_prompt =
		-- 	"You should replace the code that you are sent, only following the comments. Do not talk at all. Only output valid code. Do not provide any backticks that surround the code. Never ever output backticks like this ``` ever for any code. Any comment that is asking you for something should be removed after you satisfy them. Other comments should left alone. Do not output backticks - replies should always be less than 80chars a line"

		local system_prompt = [[
- I am a student, programmer, intern, project focused guy, so different independent projects at a time - so those information should not be mixed - even when asked interchangably
- i am also a chemistry student, all chem related answers must be accurate
- cg is shorthand for correct grammer - if not given respond normally
- my companpy work repo names are Sistent, Meshery, Meshmap, Meshery-Cloud, Meshery-extension - know these are names do not get mixed up
- only 80chars per line should be outputted
]]

		-- helper - replacer
		local helpful_prompt =
			"You are a helpful assistant. What I have sent are my notes so far. You are very curt, yet helpful - replies should always be less than 80chars a line."
		require("llm").setup({
			timeout_ms = 3000,
			services = {
				groq = {
					url = "https://api.groq.com/openai/v1/chat/completions",
					model = "llama3-70b-8192",
					api_key_name = "GROQ_API_KEY",
					system_prompt = system_prompt,
				},
				groq_help = {
					url = "https://api.groq.com/openai/v1/chat/completions",
					model = "llama3-70b-8192",
					api_key_name = "GROQ_API_KEY",
					system_prompt = helpful_prompt,
				},
				openai = {
					url = "https://api.openai.com/v1/chat/completions",
					model = "gpt-4o",
					api_key_name = "OPENAI_API_KEY",
					system_prompt = system_prompt,
				},
				openai_help = {
					url = "https://api.openai.com/v1/chat/completions",
					model = "gpt-4o",
					api_key_name = "OPENAI_API_KEY",
					system_prompt = helpful_prompt,
				},
				claude = {
					url = "https://api.anthropic.com/v1/messages",
					model = "claude-3-5-sonnet-20240620",
					api_key_name = "ANTHROPIC_API_KEY",
					system_prompt = system_prompt,
				},
				claude_help = {
					url = "https://api.anthropic.com/v1/messages",
					model = "claude-3-5-sonnet-20240620",
					api_key_name = "ANTHROPIC_API_KEY",
					system_prompt = helpful_prompt,
				},
				gemini = {
					url = "https://generativelanguage.googleapis.com/v1/models",
					model = "gemini-1.5-flash",
					api_key_name = "GEMINI_API_KEY",
					system_prompt = system_prompt,
				},
				gemini_help = {
					url = "https://generativelanguage.googleapis.com/v1/models",
					model = "gemini-1.5-flash",
					api_key_name = "GEMINI_API_KEY",
					system_prompt = helpful_prompt,
				},
			},
		})

		vim.keymap.set("v", "<leader>r", function()
			require("llm").prompt({ replace = true, service = "groq" })
		end, { desc = "Prompt with groq (replace = true)" })

		vim.keymap.set("v", "<leader>R", function()
			require("llm").prompt({ replace = false, service = "groq_help" })
		end, { desc = "Prompt with groq (replace = false)" })

		vim.keymap.set("v", "<leader>O", function()
			require("llm").prompt({ replace = false, service = "openai_help" })
		end, { desc = "Prompt with openai (replace = false)" })

		vim.keymap.set("v", "<leader>o", function()
			require("llm").prompt({ replace = true, service = "openai" })
		end, { desc = "Prompt with openai (replace = true)" })

		vim.keymap.set("n", "<leader>I", function()
			require("llm").prompt({ replace = false, service = "anthropic" })
		end, { desc = "Prompt with anthropic (replace = false)" })

		vim.keymap.set("n", "<leader>i", function()
			require("llm").prompt({ replace = true, service = "anthropic" })
		end, { desc = "Prompt with anthropic (replace = true)" })

		--all above doesnt work
		vim.keymap.set({ "n", "v" }, "<leader>mG", function()
			require("llm").prompt({ replace = false, service = "gemini" })
		end, { desc = "Prompt with gemini (replace = false) - talker" })

		vim.keymap.set({ "n", "v" }, "<leader>mg", function()
			require("llm").prompt({ replace = true, service = "gemini_help" })
		end, { desc = "Prompt with gemini (replace = true) - code helper" })

		vim.keymap.set("n", "<leader>mm", function()
			require("llm").create_llm_md()
		end, { desc = "Ask.md for llm chat" })
	end,
}
