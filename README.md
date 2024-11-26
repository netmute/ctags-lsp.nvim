# ctags-lsp.nvim

Neovim configuration for [ctags-lsp](https://github.com/netmute/ctags-lsp)

<img width="904" alt="Screenshot" src="https://github.com/user-attachments/assets/491dcc8e-3f74-465c-8657-6cd43a915b1f">

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
