local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

parser_configs.luau = {
	install_info = {
		url = "https://github.com/polychromatist/tree-sitter-luau",
		files = { "src/parser.c", "src/scanner.c" },
		branch = "main",
		generate_requires_npm = false,
		requires_generate_from_grammar = false,
	},
}

require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
})
