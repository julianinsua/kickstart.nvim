return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
    'nvim-telescope/telescope.nvim',
  },
  opts = {
    disable_hint = true,
    kind = 'split',
    signs = {
      -- { CLOSED, OPENED }
      hunk = { '', '' },
      item = { '', '' },
      section = { '', '' },
    },
  },
}
