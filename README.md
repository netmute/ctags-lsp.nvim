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
        local lspconfig = require("lspconfig")
        lspconfig.ctags_lsp.setup({})
    end,
}
```

By default the language server will attach to all filetypes.  
Attach only to certain filetypes like this:

```lua
lspconfig.ctags_lsp.setup({
    filetypes = { "ruby", "go" },
})
```
