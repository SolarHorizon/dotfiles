local terminal_augroup = vim.api.nvim_create_augroup("UserNvimTerminal", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
	command = "setlocal nonumber norelativenumber",
	group = terminal_augroup,
})

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("n", "<C-w>t", ":split|res -10|terminal<CR>")
