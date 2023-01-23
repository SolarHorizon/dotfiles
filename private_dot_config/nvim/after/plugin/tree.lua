-- vim.g.netrw_banner = 0
-- vim.g.netrw_liststyle = 3
-- vim.g.netrw_winsize = 25
--
-- vim.keymap.set("n", "T", vim.cmd(":Ex"))

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
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
})

-- STOP IT!
local api = require("nvim-tree/api")
vim.keymap.set("n", "T", api.tree.toggle)
