local lsp = require("lspconfig")
local configs = require("lspconfig.configs")
local null_ls = require("null-ls")
local treesitter = require("nvim-treesitter.configs")

if not configs.roblox_lsp then
	configs.roblox_lsp = {
		default_config = {
			cmd = { "roblox-lsp" },
			filetypes = { "lua", "luau" },
			root_dir = lsp.util.find_git_ancestor,
			single_file_support = true,
			log_level = vim.lsp.protocol.MessageType.Warning,
			settings = {
				robloxLsp = {
					telemetry = {
						enable = false,
					},
				},
			},
		},
		docs = {
			package_json = "https://raw.githubusercontent.com/NightrainsRbx/RobloxLsp/master/package.json",
			description = "https://github.com/nightrainsrbx/robloxlsp",
		},
	}
end

lsp.roblox_lsp.setup({
	settings = {
		robloxLsp = {
			diagnostics = {
				enable = false,
			},
		},
	},
})

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.selene,
	},
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd([[
			augroup LspFormatting
				autocmd! * <buffer>
				autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
			augroup END
			]])
		end
	end,
})

treesitter.setup({
	highlight = {
		enable = true,
	},
})
