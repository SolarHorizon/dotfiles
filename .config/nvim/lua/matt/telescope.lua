local builtin = require("telescope/builtin")
local nnoremap = require("matt/keymap").nnoremap

nnoremap("<C-p>", builtin.find_files)

require("telescope").setup()

