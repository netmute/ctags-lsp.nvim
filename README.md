# ctags-lsp.nvim

Neovim configuration for [ctags-lsp](https://github.com/netmute/ctags-lsp)

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
    dependencies = {
        "netmute/ctags-lsp.nvim",
        opts = {},
    },
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
