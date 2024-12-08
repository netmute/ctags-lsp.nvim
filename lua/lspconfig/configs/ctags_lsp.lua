return {
	default_config = {
		cmd = { "ctags-lsp" },
		filetypes = nil,
		root_dir = function()
			return vim.fn.getcwd()
		end,
	},
	docs = {
		description = [[
https://github.com/netmute/ctags-lsp

CTags Language Server
		]],
	},
}
