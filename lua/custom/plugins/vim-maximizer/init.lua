return {
  'szw/vim-maximizer',
  vim.keymap.set('n', '<leader>vm', '<cmd>MaximizerToggle<CR>', { desc = '[V]im [M]aximizer', silent = true }),
}
