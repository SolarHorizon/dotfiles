local plugins = {}

local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local first_time = false

if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
	first_time = true
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. packer_path)
	vim.cmd("packadd packer.nvim")
end

local packer = require("packer")

local augroup = vim.api.nvim_create_augroup("PackerUserConfig", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
	group = augroup,
	pattern = vim.fn.expand("~") .. "/.config/nvim/lua/matt/plugins.lua",
	callback = function()
		plugins.setup()
	end,
})

function plugins.setup()
	return packer.startup(function(use)
		use("wbthomason/packer.nvim")

		use({
			"nvim-telescope/telescope.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
			},
		})

		use({
			"ThePrimeagen/harpoon",
			requires = {
				"nvim-lua/plenary.nvim",
			},
		})

		use({ "neovim/nvim-lspconfig", requires = {
			"jose-elias-alvarez/null-ls.nvim",
		} })

		use({
			"hrsh7th/nvim-cmp",
			requires = {
				"L3MON4D3/LuaSnip",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-path",
				"saadparwaiz1/cmp_luasnip",
			},
		})

		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			requires = {
				"nvim-treesitter/playground",
			},
		})

		use("IndianBoy42/tree-sitter-just")

		use("nvim-tree/nvim-web-devicons")
		use("nvim-lualine/lualine.nvim")
		use("nvim-tree/nvim-tree.lua")
		use("lukas-reineke/indent-blankline.nvim")
		use("folke/tokyonight.nvim")

		if first_time then
			packer.sync()
		end
	end)
end

return plugins
