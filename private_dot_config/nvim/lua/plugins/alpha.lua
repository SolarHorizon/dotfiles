return {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("alpha").setup(require("matt.alpha.theta").config)
	end,
}
