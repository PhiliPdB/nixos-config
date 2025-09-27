return {
  'marko-cerovac/material.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    require('material').setup({
      contrast = {
        terminal = true,
        sidebars = true,
        floating_windows = false,
        cursor_line = false,
        lsp_virtual_test = true,
      },

      disable = {
        background = true,
      },
    })

    vim.g.material_style = 'darker'
    vim.cmd.colorscheme('material')
  end,
}

