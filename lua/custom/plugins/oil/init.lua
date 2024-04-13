return {
  'stevearc/oil.nvim',
  opts = {
    keymaps = {
      ['<C-v>'] = 'actions.select_vsplit',
      ['<C-x>'] = 'actions.select_split',
    },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  init = function()
    vim.keymap.set('n', '-', '<cmd>Oil<CR>')
  end,
}
