local M = {}

function M.setup()
	local configs = require("lspconfig.configs")
	local util = require("lspconfig.util")
	if not configs.ctags_lsp then
		configs.ctags_lsp = {
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
	end
end

return M
