return {
	"nvim-neo-tree/neo-tree.nvim",
	name = "neo-tree",
	config = function()
		require("neo-tree").setup({
			mappings = {
				["T"] = "open",
			},
			event_handlers = {
				{
					event = "file_opened",
					handler = function()
						require("neo-tree").close_all()
					end,
				},
			},
		})

		vim.keymap.set("n", "T", "<cmd>Neotree toggle<CR>")
	end,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
}
