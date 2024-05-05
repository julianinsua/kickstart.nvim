-- Highlight todo, notes, etc in comments
return {
  'folke/todo-comments.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local tdc = require 'todo-comments'

    vim.keymap.set('n', '<leader>ct', function()
      tdc.jump_next()
    end, { desc = '[C]ode next [t]odo comment' })

    vim.keymap.set('n', '<leader>cT', function()
      tdc.jump_prev()
    end, { desc = '[C]ode previous [T]odo comment' })

    tdc.setup()
  end,
  opts = { signs = false },
}
