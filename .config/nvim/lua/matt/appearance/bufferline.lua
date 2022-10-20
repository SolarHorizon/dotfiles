require("bufferline").setup({
	options = {
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level, _diagnostics_dict, _context)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
		indicator = { style = "none" },
		separator_style = "thin",
		offsets = {
			{
				filetype = "NvimTree",
				highlight = "PanelHeading",
				separator = "▕",
				text = "Explorer",
				text_align = "center",
			},
		},
	},
})

