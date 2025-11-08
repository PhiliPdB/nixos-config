return {
  'polarmutex/git-worktree.nvim',
  version = '^2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    -- Use telescope as a ui
    require('telescope').load_extension('git_worktree')

    -- Setup keymaps
    vim.keymap.set('n', '<C-g>ws', function()
      require('telescope').extensions.git_worktree.git_worktree()
    end, { desc = 'Switch worktree' })

    vim.keymap.set('n', '<C-g>wc', function()
      require('telescope').extensions.git_worktree.create_git_worktree()
    end, { desc = 'Create worktree' })
  end,
}
