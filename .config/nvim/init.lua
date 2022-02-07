require("plugins")
require("lsp")

-- theme
vim.cmd("colorscheme onedark")
vim.o.termguicolors = true

-- formatting
vim.o.scrolloff = 4
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.wrap = false
vim.o.signcolumn = "yes"

-- search
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.incsearch = true

-- sidebar
vim.o.number = true
vim.o.signcolumn = "yes"
vim.o.showcmd = true
vim.o.relativenumber = true

-- i dont know how to organize
vim.o.errorbells = false

