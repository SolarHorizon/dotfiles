local function bind(op, outer_opts)
	outer_opts = outer_opts or { noremap = true }
	return function(lhs, rhs, opts)
		opts = vim.tbl_extend("force", outer_opts, opts or {})
		vim.keymap.set(op, lhs, rhs, opts)
	end
end

return {
	nnoremap = bind("n"),
	noremap = bind("n", { noremap = false }),
	vnoremap = bind("v"),
	xnoremap = bind("x"),
	inoremap = bind("i"),
	tnoremap = bind("t"),
}

