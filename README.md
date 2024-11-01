```lua
-- init.lua or main configuration file

require('lazy').setup({
  {
    'plugins/ctags-lsp',  -- Path to the custom plugin file
    lazy = true,
    event = 'BufReadPost',
    config = function()
      require('plugins.ctags-lsp').setup({
        tagfiles = ".git/tags",  -- Single tagfile as a string
        -- Or specify multiple tagfiles
        -- tagfiles = { ".git/tags", "./tags" },
        filetypes = { 'python', 'javascript' },  -- Optionally specify filetypes
        settings = {},  -- Optionally specify additional LSP settings
      })
    end,
  },
})
```
