local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local util = require("lspconfig.util")

local M = {}
local initialized = false

function M.setup(opts)
	if initialized then
		return
	end
	initialized = true
	opts = opts or {}

	-- Check if the ctags_lsp server is already defined
	if not configs.ctags_lsp then
		configs.ctags_lsp = {
			default_config = {
				cmd = { "ctags-lsp" },
				filetypes = opts.filetypes or nil, -- Support all filetypes by default
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

	lspconfig.ctags_lsp.setup({})
end

return M
