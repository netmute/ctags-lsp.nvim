# ctags-lsp.nvim

Neovim configuration for [ctags-lsp](https://github.com/netmute/ctags-lsp)

<img width="642" alt="screenshot" src="https://github.com/user-attachments/assets/19cb348a-4788-4f6b-892c-b385c2b544e8">

## Installation

Get the language server:

```
brew install netmute/tap/ctags-lsp
```

Setup in neovim:

```lua
-- lazy.nvim
{
    "neovim/nvim-lspconfig",
    dependencies = "netmute/ctags-lsp.nvim",
    config = function()
        require("lspconfig").ctags_lsp.setup({})
    end,
}
```

It attaches to all filetypes by default.  
Need it for specific filetypes only? It’s configurable:

```lua
lspconfig.ctags_lsp.setup({
    filetypes = { "ruby", "go" },
})
```
