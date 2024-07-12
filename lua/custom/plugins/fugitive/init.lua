return {
  'tpope/vim-fugitive',
  vim.keymap.set('n', '<leader>gw', '<cmd>Gwrite<CR>', { desc = '[G]it [W]rite (:Gwrite)' }),
  vim.keymap.set('n', '<leader>gf', '<cmd>G blame<CR>', { desc = '[G]it [F]ile Blame' }),
}
