return {
	"navarasu/onedark.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		function Od()
			require("onedark").setup({
				-- style = 'warmer',
				code_style = {
					comments = "none",
					keywords = "none",
					functions = "none",
					strings = "none",
					variables = "none",
				},
				colors = {
					bg0 = "#111111",
					bg1 = "#000000",
				},
			})

			require("onedark").load()
		end
		Od()
	end,
}
