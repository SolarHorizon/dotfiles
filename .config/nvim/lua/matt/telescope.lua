local builtin = require("telescope/builtin")

vim.keymap.set("n", "<C-p>", builtin.find_files)
vim.keymap.set("n", "<C-g>", builtin.live_grep)

require("telescope").setup()
