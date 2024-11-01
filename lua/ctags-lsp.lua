local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local util = require("lspconfig.util")
local tempfile_path = vim.fn.tempname() -- Temporary file for concatenated tagfiles if needed

local M = {}
local initialized = false

function M.setup(opts)
	if initialized then
		return
	end
	initialized = true
	opts = opts or {}

	-- Ensure tagfiles are appended to vim.opt.tags
	if opts.tagfiles then
		-- Convert single string to table if needed
		local tagfiles = type(opts.tagfiles) == "string" and { opts.tagfiles } or opts.tagfiles

		-- Append each tagfile to vim.opt.tags
		for _, tagfile in ipairs(tagfiles) do
			vim.opt.tags:append(tagfile)
		end
	end

	-- Check if the ctags_lsp server is already defined
	if not configs.ctags_lsp then
		configs.ctags_lsp = {
			default_config = {
				cmd = { "ctags-lsp" },
				filetypes = opts.filetypes or nil, -- Support all filetypes by default
				root_dir = function(fname)
					-- Locate the .git directory if it exists
					local git_root = util.find_git_ancestor(fname)
					-- Check for tagfiles, if none, return nil to prevent starting the LSP
					local tagfiles = vim.fn.tagfiles()
					if #tagfiles == 0 then
						return nil
					end
					return git_root or util.path.dirname(fname)
				end,
				settings = opts.settings or {},
				on_new_config = function(new_config)
					-- Get tagfiles and concatenate if there are multiple
					local tagfiles = vim.fn.tagfiles()
					if #tagfiles > 1 then
						-- Concatenate tagfiles into a single temporary file
						local tempfile = io.open(tempfile_path, "w")
						for _, tagfile in ipairs(tagfiles) do
							for line in io.lines(tagfile) do
								tempfile:write(line, "\n")
							end
						end
						tempfile:close()
						new_config.cmd = { "ctags-lsp", tempfile_path }
					elseif #tagfiles == 1 then
						-- Use the single tagfile
						local tagfile = vim.fn.fnamemodify(tagfiles[1], ":p")
						new_config.cmd = { "ctags-lsp", tagfile }
					end
				end,
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
