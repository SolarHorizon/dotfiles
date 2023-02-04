return {
	"folke/noice.nvim",
	-- enabled = false,
	opts = {
		cmdline = {
			enabled = false,
			--	view = "cmdline",
		},
		messages = {
			enabled = false,
		},
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
		presets = {
			bottom_search = true,
			command_palette = false,
			long_message_to_split = true,
			lsp_doc_border = true,
		},
		views = {
			mini = {
				position = { row = -3 },
				win_options = {
					winblend = 0,
				},
			},
		},
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
		"nvim-treesitter/nvim-treesitter",
	},
}
