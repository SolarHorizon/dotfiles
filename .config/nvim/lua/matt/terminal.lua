local terminal_augroup = vim.api.nvim_create_augroup("terminal", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
	command = "setlocal nonumber norelativenumber",
	group = terminal_augroup,
})

vim.keymap.set("t", "<C-w>n", "<C-\\><C-n>")
vim.keymap.set("n", "<C-w>t", ":terminal<CR>")
