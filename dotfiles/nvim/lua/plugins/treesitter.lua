local parser_install_dir = vim.fn.stdpath('cache') .. '/treesitters'
vim.fn.mkdir(parser_install_dir, 'p')
vim.opt.runtimepath:append(parser_install_dir)

return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  opts = {
    parser_install_dir = parser_install_dir,
    ensure_installed = { 'bash', 'diff', 'lua', 'nix', 'markdown' },
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlights = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
  },
}
