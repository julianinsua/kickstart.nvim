return { -- Adds git related signs to the gutter, as well as utilities for managing changes
  -- See `:help gitsigns` to understand what the configuration keys do
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { hl = 'gitsignsadd', text = '│', numhl = 'gitsignsaddnr', linehl = 'gitsignsaddln' },
      change = { hl = 'gitsignschange', text = '│', numhl = 'gitsignschangenr', linehl = 'gitsignschangeln' },
      delete = { hl = 'gitsignsdelete', text = '_', numhl = 'gitsignsdeletenr', linehl = 'gitsignsdeleteln' },
      topdelete = { hl = 'gitsignsdelete', text = '‾', numhl = 'gitsignsdeletenr', linehl = 'gitsignsdeleteln' },
      changedelete = { hl = 'gitsignschange', text = '~', numhl = 'gitsignschangenr', linehl = 'gitsignschangeln' },
      untracked = { hl = 'gitsignsadd', text = '┆', numhl = 'gitsignsaddnr', linehl = 'gitsignsaddln' },
    },
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'

      vim.keymap.set('n', '<leader>ch', function()
        gitsigns.nav_hunk 'next'
      end, { buffer = bufnr, desc = '[C]ode next git [H]unk' })

      vim.keymap.set('n', '<leader>cH', function()
        gitsigns.nav_hunk 'prev'
      end, { buffer = bufnr, desc = '[C]ode previous git [H]unk' })

      vim.keymap.set('n', '<leader>cB', gitsigns.toggle_current_line_blame, { buffer = bufnr, desc = '[C]ode [B]lame' })
    end,
  },
}
