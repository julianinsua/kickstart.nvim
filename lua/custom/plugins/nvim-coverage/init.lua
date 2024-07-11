return {
  'andythigpen/nvim-coverage',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    commands = true, -- create commands
    highlights = {
      -- customize highlight groups created by the plugin
      covered = { fg = '#74c7ec' }, -- #C3E88D supports style, fg, bg, sp (see :h highlight-gui)
      uncovered = { fg = '#fab387' }, -- #F07178
    },
    signs = {
      -- use your own highlight groups or text markers
      covered = { hl = 'CoverageCovered', text = '' },
      uncovered = { hl = 'CoverageUncovered', text = '' },
    },
    summary = {
      -- customize the summary pop-up
      min_coverage = 80.0, -- minimum coverage threshold (used for highlighting)
    },
  },
  keys = {
    {
      '<leader>tc',
      function()
        require('coverage').load(true)
      end,
      desc = '[T]est [C]overage',
    },
    {
      '<leader>tC',
      function()
        require('coverage').clear()
      end,
    },
    desc = '[T]est Coverage [C]lear',
  },
}
