require("tokyonight").setup({
	style = "storm",
	transparent = true,
	styles = {
		sidebars = "transparent",
		floats = "transparent",
	},
})

require("lualine").setup({
	options = {
		component_separators = { left = "", right = "" },
		globalstatus = true,
		section_separators = { left = "", right = "" },
		theme = "tokyonight",
	},
	sections = {
		lualine_c = {
			{ "filename", path = 1 },
		},
	},
})

vim.cmd.colorscheme("tokyonight")
