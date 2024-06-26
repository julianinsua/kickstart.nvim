return {
  'shatur/neovim-session-manager',
  config = function()
    require('session_manager').setup {
      autoload_mode = require('session_manager.config').AutoloadMode.Disabled,
    }

    vim.keymap.set(
      'n',
      '<leader>vsl',
      '<cmd>SessionManager load_current_dir_session<cr>',
      { noremap = true, desc = '[s]ession [l]oad: loads last session for the current directory' }
    )
    vim.keymap.set(
      'n',
      '<leader>vsL',
      '<cmd>SessionManager load_last_session<cr>',
      { noremap = true, desc = '[s]ession load [L]ast: loads last session for the current directory' }
    )
  end,
}
