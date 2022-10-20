local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. packer_path)
end

local packer_user_config = vim.api.nvim_create_augroup("packer_user_config", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
	command = "source <afile> | PackerCompile",
	group = packer_user_config,
	pattern = "init.lua",
})

local packer = require("packer")

return packer.startup(function(use)
	use("wbthomason/packer.nvim")

	use("neovim/nvim-lspconfig")
	use("nvim-lua/plenary.nvim")
	use("nvim-telescope/telescope.nvim")

	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-path")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")

	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	use("nvim-treesitter/playground", { requires = "nvim-treesitter/nvim-treesitter" })
	use("jose-elias-alvarez/null-ls.nvim", { requires = "nvim-lua/plenary.nvim" })

	use("nvim-tree/nvim-web-devicons")
	use("nvim-tree/nvim-tree.lua", { requires = "nvim-tree/nvim-web-devicons", tag = "nightly" })
	use("akinsho/bufferline.nvim", { requires = "nvim-tree/nvim-web-devicons", tag = "v3.*" })
	use("nvim-lualine/lualine.nvim", { requires = "nvim-tree/nvim-web-devicons" })

	use("olimorris/onedarkpro.nvim")
end)
