-- plugins/ctags-lsp.lua

local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local util = require("lspconfig.util")
local tempfile_path = vim.fn.tempname() -- Temporary file for concatenated tagfiles if needed

-- Utility function to log to :messages
local function log(msg)
	vim.api.nvim_echo({ { msg, "InfoMsg" } }, true, {})
end

local M = {}

function M.setup(opts)
	opts = opts or {}

	-- Ensure tagfiles are appended to vim.opt.tags
	if opts.tagfiles then
		-- Convert single string to table if needed
		local tagfiles = type(opts.tagfiles) == "string" and { opts.tagfiles } or opts.tagfiles

		-- Append each tagfile to vim.opt.tags
		for _, tagfile in ipairs(tagfiles) do
			vim.opt.tags:append(tagfile)
		end
		log("ctags-lsp: Appended tagfiles to vim.opt.tags: " .. table.concat(tagfiles, ", "))
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
						log("ctags-lsp: No tagfiles found; LSP will not start.")
						return nil
					end
					log("ctags-lsp: Tagfile(s) found: " .. table.concat(tagfiles, ", "))
					log("ctags-lsp: Using root directory: " .. (git_root or util.path.dirname(fname)))
					return git_root or util.path.dirname(fname)
				end,
				settings = opts.settings or {},
				on_new_config = function(new_config, root_dir)
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
						log("ctags-lsp: Multiple tagfiles found; concatenated into temporary file: " .. tempfile_path)
						new_config.cmd = { "ctags-lsp", tempfile_path }
					elseif #tagfiles == 1 then
						-- Use the single tagfile
						local tagfile = vim.fn.fnamemodify(tagfiles[1], ":p")
						log("ctags-lsp: Single tagfile used: " .. tagfile)
						new_config.cmd = { "ctags-lsp", tagfile }
					end

					-- Log the final command used to start `ctags-lsp`
					log("ctags-lsp: Starting with command: " .. table.concat(new_config.cmd, " "))
				end,
			},
		}
	end

	-- Initialize the LSP configuration
	lspconfig.ctags_lsp.setup({})
	log("ctags-lsp setup completed.")
end

return M

