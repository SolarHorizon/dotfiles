local configs = require("lspconfig.configs")
local lsp = require("lspconfig")

if not configs.roblox_lsp then
	configs.roblox_lsp = {
		default_config = {
			cmd = { "roblox-lsp" },
			filetypes = { "luau", "lua" },
			root_dir = lsp.util.find_git_ancestor,
			single_file_support = true,
			log_level = vim.lsp.protocol.MessageType.Warning,
			settings = {
				robloxLsp = {
					diagnostics = { enable = false },
					telemetry = { enable = false },
				},
			},
		},
	}
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function setup_lsp(server, config)
	config = config or {}
	config.capabilities = capabilities

	function config.on_attach(_client, _bufnr)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
		vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0 })
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0 })
		vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = 0 })
		vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { buffer = 0 })
		vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, { buffer = 0 })
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0 })
		vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", { buffer = 0 })
	end

	server.setup(config)
end

setup_lsp(lsp.roblox_lsp)
setup_lsp(lsp.rust_analyzer)
setup_lsp(lsp.tsserver)
setup_lsp(lsp.eslint)
setup_lsp(lsp.emmet_ls)
