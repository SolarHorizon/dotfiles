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

		-- automatically download globalTypes when luau-lsp updates
		local luau_path = vim.fs.normalize("~/.local/share/luau-lsp")

		require("mason-registry"):on(
			"package:install:success",
			vim.schedule_wrap(function(pkg, _handle)
				if pkg.name ~= "luau-lsp" then
					return
				end

				vim.fn.system({ "update-luau-lsp" })

				--local gh = "https://raw.githubusercontent.com"

				--vim.fn.system({
				--	"curl",
				--	gh
				--		.. "/JohnnyMorganz/luau-lsp/master/scripts/globalTypes.d.lua",
				--	"--output",
				--	luau_path .. "/globalTypes.d.lua",
				--})

				--vim.fn.system({
				--	"curl",
				--	gh
				--		.. "/MaximumADHD/Roblox-Client-Tracker/roblox/api-docs/en-us.json",
				--	"--output",
				--	luau_path .. "/docs.json",
				--})
			end)
		)

		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local lspconfig = require("lspconfig")

		local function set_keymap(_client, _bufnr)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
			vim.keymap.set(
				"n",
				"gt",
				vim.lsp.buf.type_definition,
				{ buffer = 0 }
			)
			vim.keymap.set(
				"n",
				"gi",
				vim.lsp.buf.implementation,
				{ buffer = 0 }
			)
			vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = 0 })
			vim.keymap.set(
				"n",
				"<leader>dj",
				vim.diagnostic.goto_next,
				{ buffer = 0 }
			)
			vim.keymap.set(
				"n",
				"<leader>dk",
				vim.diagnostic.goto_prev,
				{ buffer = 0 }
			)
			vim.keymap.set(
				"n",
				"<leader>ca",
				vim.lsp.buf.code_action,
				{ buffer = 0 }
			)
			vim.keymap.set(
				"n",
				"<leader>dl",
				"<cmd>Telescope diagnostics<cr>",
				{ buffer = 0 }
			)
		end

		local function setup(name, config)
			config = config or {}
			config.capabilities = capabilities

			local on_attach = config.on_attach

			function config.on_attach(client, bufnr)
				set_keymap(client, bufnr)

				if on_attach then
					on_attach(client, bufnr)
				end
			end

			lspconfig[name].setup(config)
		end

		require("mason-lspconfig").setup_handlers({
			function(server_name)
				setup(server_name)
			end,
			["luau_lsp"] = function()
				local augroup =
					vim.api.nvim_create_augroup("luau-lsp", { clear = true })

				local function generate_sourcemap()
					vim.notify("regenerating sourcemap", "info", {
						title = "luau-lsp",
					})

					vim.fn.system({
						"rojo",
						"sourcemap",
						"--output",
						"./sourcemap.json",
					})
				end

				generate_sourcemap()

				setup("luau_lsp", {
					cmd = {
						"luau-lsp",
						"lsp",
						"--definitions=" .. luau_path .. "/roblox.d.lua",
						"--definitions=" .. luau_path .. "/testez.d.lua",
						"--docs=" .. luau_path .. "/docs.json",
					},
					on_attach = function(_client, _bufnr)
						-- replace with something more robust later
						vim.api.nvim_create_autocmd("BufWritePost", {
							group = augroup,
							callback = generate_sourcemap,
						})
					end,
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
	},
}
