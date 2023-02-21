local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

local terminal_augroup =
	vim.api.nvim_create_augroup("UserNvimTerminal", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
	command = "setlocal nonumber norelativenumber",
	group = terminal_augroup,
})

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set(
	"n",
	"gx",
	":execute '!pwsh.exe -c Start-Process ' . shellescape(expand('<cfile>'), 1)<CR>"
	--":silent execute '!$OPENER ' . shellescape(expand('<cfile>'), 1)<CR>"
)

--test('gx', [[:execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>]])

vim.o.scrolloff = 4
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.wrap = false
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.termguicolors = true

vim.o.number = true
vim.o.signcolumn = "yes"
vim.o.relativenumber = true

vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.incsearch = true

vim.o.errorbells = false

vim.g.mapleader = " "

require("lazy").setup("plugins", {
	install = {
		missing = true,
		colorscheme = { "tokyonight" },
	},
	performance = {
		rtp = {
			disabled_plugins = { "netrwPlugin" },
		},
	},
})
