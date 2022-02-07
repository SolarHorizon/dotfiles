vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerCompile
	augroup end
]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	use("neovim/nvim-lspconfig")
	use("mfussenegger/nvim-lint")
	use("ckipp01/stylua-nvim")
	use("nvim-lua/plenary.nvim")
	use("nvim-telescope/telescope.nvim")
	use{"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
	use("nvim-treesitter/playground")

	use("joshdick/onedark.vim")
	use{
		"glepnir/galaxyline.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		-- config = function() 
		-- end
	}
end)

