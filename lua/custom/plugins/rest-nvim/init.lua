return {
  'rest-nvim/rest.nvim',
  ft = 'http',
  dependencies = { 'luarocks.nvim' },
  config = function()
    require('rest-nvim').setup {
      keybinds = {
        {
          '<leader>rr',
          '<cmd>Rest run<cr>',
          '[R]est [R]un request under the cursor',
        },
        {
          '<localleader>rl',
          '<cmd>Rest run last<cr>',
          '[R]est [R]un last request',
        },
      },
    }
  end,
}
