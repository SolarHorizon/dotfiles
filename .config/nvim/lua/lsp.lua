local lsp = require("lspconfig")
local configs = require("lspconfig.configs")
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
						enable = false
					}
				}
			}
		},
		docs = {
			package_json = "https://raw.githubusercontent.com/NightrainsRbx/RobloxLsp/master/package.json",
			description = "https://github.com/nightrainsrbx/robloxlsp",
		}
	}
end

lsp.roblox_lsp.setup({
	robloxLsp = {
		endAutoCompletion = true,
		searchDepth = 2,
	}
})

treesitter.setup({
	highlight = {
		enable = true,
	}
})

