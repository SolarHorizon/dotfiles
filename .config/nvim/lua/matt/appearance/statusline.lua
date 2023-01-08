require("lualine").setup({
	options = {
		globalstatus = true,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_c = {
			{ "filename", path = 1 },
		},
	},
})
