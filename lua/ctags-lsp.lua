-- plugins/ctags-lsp.lua

local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')
local util = require('lspconfig.util')
local tempfile_path = vim.fn.tempname()  -- Temporary file for concatenated tagfiles if needed

if not configs.ctags_lsp then
  configs.ctags_lsp = {
    default_config = {
      cmd = { 'ctags-lsp' },
      filetypes = nil,  -- Support all filetypes
      root_dir = function(fname)
        -- Locate the .git directory if it exists
        local git_root = util.find_git_ancestor(fname)
        -- Check for tagfiles, if none, return nil to prevent starting the LSP
        if #vim.fn.tagfiles() == 0 then
          return nil
        end
        return git_root or util.path.dirname(fname)
      end,
      settings = {},
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
          new_config.cmd = { 'ctags-lsp', tempfile_path }
        elseif #tagfiles == 1 then
          -- Use the single tagfile
          local tagfile = vim.fn.fnamemodify(tagfiles[1], ':p')
          new_config.cmd = { 'ctags-lsp', tagfile }
        end
      end,
    },
  }
end

-- Initialize the LSP configuration
lspconfig.ctags_lsp.setup({})