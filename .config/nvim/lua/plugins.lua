vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerCompile
	augroup end
]])

return require("packer").startup(function(use)
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

	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use({ "nvim-treesitter/playground", requires = "nvim-treesitter/nvim-treesitter" })
	use({ "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim" } })

	use("joshdick/onedark.vim")
end)
