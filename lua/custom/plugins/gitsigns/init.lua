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
  },
}
