vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
	disable_netrw = true,
	diagnostics = {
		enable = true,
	},
	git = {
		ignore = false,
	},
})

local api = require("nvim-tree/api")
vim.keymap.set("n", "T", api.tree.toggle)
