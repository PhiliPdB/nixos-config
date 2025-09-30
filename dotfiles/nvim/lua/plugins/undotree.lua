return {
  'mbbill/undotree',
  config = function()
    -- Set undotree options
    vim.g.undotree_SetFocusWhenToggle = 1

    -- Set keymap to toggle undotree
    vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Toggle [U]ndotree' })
  end,
}
