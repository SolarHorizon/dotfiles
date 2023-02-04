return {
	"rcarriga/nvim-notify",
	config = function()
		local colors = require("tokyonight.colors").setup()

		require("notify").setup({
			background_colour = colors.bg_dark,
		})

		-- vim.notify = require("notify")

		require("telescope").load_extension("notify")
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope.nvim",
		"folke/tokyonight.nvim",
	},
}
