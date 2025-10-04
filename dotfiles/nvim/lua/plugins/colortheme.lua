return {
  'navarasu/onedark.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    local onedark = require('onedark')
    onedark.setup({
      style = 'darker',
      transparent = true,

      ending_tildes = true,

      diagnostics = {
        background = false,
      },
    })

    --Enable theme
    onedark.load()
  end,
}
