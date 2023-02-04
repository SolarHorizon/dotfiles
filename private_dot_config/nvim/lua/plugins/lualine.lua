return {
	"nvim-lualine/lualine.nvim",
	name = "lualine",
	opts = {
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
	},
}
