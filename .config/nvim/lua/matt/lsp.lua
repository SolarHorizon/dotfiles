local cmp = require("cmp")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local configs = require("lspconfig.configs")
local lsp = require("lspconfig")
local luasnip = require("luasnip")
local null_ls = require("null-ls")

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

local format_augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

null_ls.setup({
	sources = {
		-- lua
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.selene,

		-- sh
		null_ls.builtins.diagnostics.shellcheck,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				group = format_augroup,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})

local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

local function setup_lsp(server, config)
	config.capabilities = capabilities

	function config.on_attach()
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
		vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0 })
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0 })
		vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = 0 })
		vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { buffer = 0 })
		vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, { buffer = 0 })
		vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", { buffer = 0 })
	end

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
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "roblox_lsp" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
	}),
})

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		-- cmp on WSL can't handle :!
		vim.fn.has("wsl") == 0 and { name = "cmdline" }
			or { name = "cmdline", keyword_pattern = [=[[^[:blank:]\!]*]=], keyword_length = 3 },
	}),
})
