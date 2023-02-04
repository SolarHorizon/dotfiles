return {
	"nvim-telescope/telescope.nvim",
	config = function()
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<C-p>", builtin.find_files)
		vim.keymap.set("n", "<C-g>", builtin.live_grep)

		-- enable syntax highlighting for unsupported filetypes in preview
		require("plenary.filetype").add_file("luau")
		require("plenary.filetype").add_file("just")

		require("telescope").setup()
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
