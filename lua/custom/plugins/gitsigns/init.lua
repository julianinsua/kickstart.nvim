return { -- Adds git related signs to the gutter, as well as utilities for managing changes
  -- See `:help gitsigns` to understand what the configuration keys do
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '│' },
      change = { text = '│' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    },
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'

      vim.keymap.set('n', '<leader>gh', function()
        gitsigns.nav_hunk 'next'
      end, { buffer = bufnr, desc = 'Next [G]it [H]unk' })

      vim.keymap.set('n', '<leader>gH', function()
        gitsigns.nav_hunk 'prev'
      end, { buffer = bufnr, desc = 'Previous [G]it [H]unk' })

      vim.keymap.set('n', '<leader>gl', gitsigns.toggle_current_line_blame, { buffer = bufnr, desc = '[G]it [L]ine Blame' })
    end,
  },
}
