```lua
-- init.lua or main configuration file

require('lazy').setup({
  -- ... other plugins ...

  {
    'plugins/ctags-lsp',  -- Path to the custom plugin file
    lazy = true,
    event = 'BufReadPost',
  },

  -- ... other plugins ...
})
```
