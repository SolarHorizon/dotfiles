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

				vim.fn.system({ "update-luau-types" })
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
			vim.keymap.set("n", "<leader>e", function()
				vim.diagnostic.open_float(0, { scope = "line" })
			end, { buffer = 0 })
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
			-- probably should extract all of this stuff into its own module
			["luau_lsp"] = function()
				local augroup =
					vim.api.nvim_create_augroup("luau-lsp", { clear = true })

				local function generate_sourcemap(client)
					vim.fn.system({
						"rojo",
						"sourcemap",
						"--output",
						"./sourcemap.json",
					})

					vim.fn.system({
						"wally-package-types",
						"--sourcemap",
						"./sourcemap.json",
						"./Packages/",
					})

					if client then
						client.notify("regenerating sourcemap")
					end
				end

				generate_sourcemap()

				local definitions = { "roblox", "testez" }

				local flags = {
					LuauInterpolatedStringBaseSupport = true,
				}

				local cmd = {
					"luau-lsp",
					"lsp",
					"--docs=" .. luau_path .. "/docs.json",
				}

				for name, value in pairs(flags) do
					table.insert(
						cmd,
						#cmd + 1,
						string.format(
							"--flag:%s=%s",
							tostring(name),
							tostring(value)
						)
					)
				end

				for _, file in ipairs(definitions) do
					table.insert(
						cmd,
						#cmd + 1,
						string.format(
							"--definitions=%s/%s.d.lua",
							luau_path,
							file
						)
					)
				end

				setup("luau_lsp", {
					cmd = cmd,
					on_attach = function(client, _bufnr)
						-- replace with something more robust later
						vim.api.nvim_create_autocmd("BufWritePost", {
							group = augroup,
							callback = function()
								generate_sourcemap(client)
							end,
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
