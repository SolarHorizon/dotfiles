require("matt")

-- formatting
vim.o.scrolloff = 4
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.wrap = false
vim.o.splitright = true
vim.o.splitbelow = true
vim.opt.fillchars = {
	vert = "▕",
	vertright = "▕",
	eob = " ",
}

-- search
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.incsearch = true

-- sidebar
vim.o.number = true
vim.o.signcolumn = "yes"
vim.o.relativenumber = true

-- i dont know how to organize
vim.o.errorbells = false
