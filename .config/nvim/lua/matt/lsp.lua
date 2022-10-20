local cmp = require("cmp")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local configs = require("lspconfig.configs")
local lsp = require("lspconfig")
local luasnip = require("luasnip")
local null_ls = require("null-ls")
local treesitter = require("nvim-treesitter.configs")

local function isWSL()
	return vim.fn.has("wsl") == 1
end

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

null_ls.setup({
	sources = {
		-- lua
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.selene,

		-- sh
		null_ls.builtins.diagnostics.shellcheck,
	},
	on_attach = function(client)
		if client.server_capabilities.document_formatting then
			vim.cmd([[
			augroup LspFormatting
				autocmd! * <buffer>
				autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
			augroup END
			]])
		end
	end,
})

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm(),
	}),
	sources = cmp.config.sources({
		{ name = "roblox_lsp" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
	}),
})

cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

if not isWSL() then
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})
end

local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

local function setup_lsp(server, config)
	config.capabilities = capabilities
	server.setup(config)
end

setup_lsp(lsp.roblox_lsp, {
	settings = {
		robloxLsp = {
			diagnostics = {
				enable = false,
			},
		},
	},
})

treesitter.setup({
	highlight = {
		enable = true,
	},
})
