local util = require("lspconfig.util")

return {
	default_config = {
		cmd = { "ctags-lsp" },
		filetypes = nil,
		root_dir = util.find_git_ancestor,
	},
	docs = {
		description = [[
https://github.com/netmute/ctags-lsp

CTags Language Server
		]],
	},
}
