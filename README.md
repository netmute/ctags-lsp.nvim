# Deprecated!

The configuration provided by this repository was deprecated in Neovim 0.11+. 

You can now simply configure ctags-lsp like this:

```lua
-- lazy.nvim
{
	"neovim/nvim-lspconfig",
	ft = { "ruby", "python" },
	config = function()
		vim.lsp.config("ctags_lsp", {
			cmd = { "ctags-lsp" },
			filetypes = { "ruby", "python" },
			root_dir = vim.uv.cwd(),
		})
		vim.lsp.enable("ctags_lsp")
	end,
},
```
