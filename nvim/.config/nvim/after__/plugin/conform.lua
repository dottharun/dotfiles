-- require("conform").setup({
--     formatters_by_ft = {
--         -- lua = { "stylua" },
--         -- -- Conform will run multiple formatters sequentially
--         -- python = { "isort", "black" },
--         -- -- Use a sub-list to run only the first available formatter
--         -- javascript = { { "prettierd", "prettier" } },
--
--         cpp = { "clang_format" },
--     },
--
--     format_on_save = {
--         lsp_fallback = true,
--     },
-- })

-- -- format on save
-- vim.api.nvim_create_autocmd("BufWritePre", {
--     pattern = "*",
--     callback = function(args)
--         require("conform").format({ bufnr = args.buf })
--     end,
-- })

require("conform").setup({
	formatters_by_ft = {
		cpp = { "clang_format" },
		nix = { "nixfmt" },
	},
	format_on_save = function(bufnr)
		-- Disable with a global or buffer-local variable
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		end
		return { timeout_ms = 500, lsp_fallback = true }
	end,
})

vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = "Re-enable autoformat-on-save",
})

-- print("hello from conform")
vim.cmd([[FormatDisable]])

vim.keymap.set("n", "<leader>vff", "<cmd>FormatEnable<CR>:w<CR>", { desc = "[f]ormat enable" })
vim.keymap.set("n", "<leader>vfk", "<cmd>FormatDisable<CR>", { desc = "format [k]ill" })
