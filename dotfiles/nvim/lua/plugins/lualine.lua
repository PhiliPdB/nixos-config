local diagnostics = {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  sections = { 'error', 'warn', 'info' },
  symbols = {
    error = ' ',
    warn = ' ',
    info = '󰋼 ',
    hint = '󰌵 ',
  },
  colored = true,
  update_in_insert = false,
  always_visible = false,
  cond = function()
    return vim.bo.filetype ~= 'markdown'
  end,
}

local diff = {
  'diff',
  colored = true,
  symbols = { added = ' ', modified = ' ', removed = ' ' },
}

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      options = {
        component_separators = '',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', diff },
        lualine_c = { 'filename', diagnostics },
        lualine_x = { 'fileformat', 'filetype' },
        lualine_y = { 'lsp_status' },
        lualine_z = { 'location' },
      },
    })
  end,
}
