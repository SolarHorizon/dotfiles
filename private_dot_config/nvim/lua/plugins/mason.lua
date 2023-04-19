return {
	"williamboman/mason.nvim",
	config = function()
		require("mason").setup()

		require("mason-lspconfig").setup({
			ensure_installed = {
				"luau_lsp",
				"rust_analyzer",
			},
		})

		require("mason-null-ls").setup({
			automatic_installation = true,
		})

		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local lspconfig = require("lspconfig")

		local function set_keymap(ev)
			local function map_key(key, callback)
				vim.keymap.set("n", key, callback, { buffer = ev.buf })
			end

			map_key("K", vim.lsp.buf.hover)
			map_key("gd", vim.lsp.buf.definition)
			map_key("gt", vim.lsp.buf.type_definition)
			map_key("gi", vim.lsp.buf.implementation)
			map_key("<leader>r", vim.lsp.buf.rename)
			map_key("<leader>dj", vim.diagnostic.goto_next)
			map_key("<leader>dk", vim.diagnostic.goto_prev)
			map_key("<leader>ca", vim.lsp.buf.code_action)
			map_key("<leader>dl", "<cmd>Telescope diagnostics<cr>")

			map_key("<leader>e", function()
				vim.diagnostic.open_float(0, { scope = "line" })
			end)

			map_key("<leader>ping", function()
				vim.notify("pong")
			end)
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspKeymap", {}),
			callback = set_keymap,
		})

		local function setup(name, config)
			config = config or {}
			config.capabilities = capabilities
			lspconfig[name].setup(config)
		end

		require("mason-lspconfig").setup_handlers({
			function(server_name)
				setup(server_name)
			end,
			["luau_lsp"] = function()
				local path = vim.fs.normalize("~/.local/share/luau-lsp")
				local types = path .. "/types"
				local docs = path .. "/docs"

				require("luau-lsp").setup({
					sourcemap = {
						enabled = true,
						autogenerate = true,
						--rojo_project_file = "dev.project.json",
					},
					server = {
						types = {
							--roblox = true,
							definition_files = {
								types .. "/roblox.d.luau",
								types .. "/lune.d.luau",
								types .. "/testez.d.luau",
							},
							documentation_files = {
								docs .. "/roblox.json",
								docs .. "/lune.json",
							},
						},
						settings = {
							require = {
								mode = "relativeToFile",
							},
							completion = {
								suggestImports = true,
							},
						},
					},
				})
			end,
		})
	end,
	dependencies = {
		"neovim/nvim-lspconfig",
		"jose-elias-alvarez/null-ls.nvim",
		"jay-babu/mason-null-ls.nvim",
		"williamboman/mason-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		"lopi-py/luau-lsp.nvim",
	},
}
