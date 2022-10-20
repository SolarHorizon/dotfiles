local tnoremap = require("matt/keymap").tnoremap

tnoremap("<C-w>n", "<C-\\><C-n>")

local terminal_augroup = vim.api.nvim_create_augroup("terminal", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
	command = "setlocal nonumber norelativenumber",
	group = terminal_augroup,
})
