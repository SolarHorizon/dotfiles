return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local parser_configs =
			require("nvim-treesitter.parsers").get_parser_configs()

		parser_configs.just = {
			install_info = {
				url = "https://github.com/IndianBoy42/tree-sitter-just",
				files = { "src/parser.c", "src/scanner.cc" },
				branch = "main",
			},
		}

		require("luau-lsp").treesitter()

		require("nvim-treesitter.configs").setup({
			highlight = {
				enable = true,
			},
		})
	end,
	dependencies = {
		"nvim-treesitter/playground",
		"IndianBoy42/tree-sitter-just",
	},
}
