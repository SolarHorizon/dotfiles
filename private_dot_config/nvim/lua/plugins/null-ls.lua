local format_augroup =
	vim.api.nvim_create_augroup("LspFormatting", { clear = true })

local node_modules = {
	prefer_local = "node_modules/.bin",
}

return {
	"jose-elias-alvarez/null-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				-- lua
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.diagnostics.selene,

				-- rust
				null_ls.builtins.formatting.rustfmt,

				-- sh
				null_ls.builtins.diagnostics.shellcheck,

				-- yaml
				null_ls.builtins.diagnostics.actionlint,

				-- ts & js
				null_ls.builtins.formatting.prettier.with(node_modules),
				null_ls.builtins.diagnostics.eslint.with(node_modules),
			},
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({
						group = format_augroup,
						buffer = bufnr,
					})

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
	end,
}
