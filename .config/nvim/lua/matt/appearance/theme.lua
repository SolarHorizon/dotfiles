vim.o.termguicolors = true

local theme = require("onedarkpro")

theme.setup({
	options = {
		window_unfocused_color = false,
	},
	highlights = {
		-- editor
		Cursor = { bg = "${blue}" },
		WinSeparator = { bg = "NONE", fg = "${bg_statusline}" },

		-- bufferline
		BufferLineOffsetSeparator = { bg = "NONE", fg = "${bg_statusline}" },
		PanelHeading = { bg = "${bg}" },

		-- nvim-tree
		NvimTreeEmptyFolderIcon = { fg = "${gray}" },
		NvimTreeFolderIcon = { fg = "${blue}" },
		NvimTreeOpenedFolderName = { fg = "${blue}" },
		NvimTreeWinSeparator = { bg = "NONE", fg = "${bg_statusline}" },

		-- treesitter
		["@constant.builtin"] = { fg = "${orange}" },
		["@constructor"] = { fg = "${fg}" },
		["@punctuation.bracket"] = { fg = "${fg}" },

		-- lua
		["@keyword.operator"] = { fg = "${purple}" },
		["@constructor.lua"] = { fg = "${fg}" },
		["@field.lua"] = { fg = "${red}" },
		["@function.builtin.lua"] = { fg = "${cyan}", style = "NONE" },
		["@function.call.lua"] = { fg = "${blue}", style = "NONE" },
		["@parameter.lua"] = { fg = "${red}", style = "italic" },
		["@punctuation.bracket.lua"] = { fg = "${fg}" },
		["@variable.lua"] = { fg = "${red}" },
		["@method.lua"] = { fg = "${blue}", style = "NONE" },
	},
})

theme.load()
