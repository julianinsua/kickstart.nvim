return {
  require 'custom.plugins.catpuccin',
  require 'custom.plugins.conform-nvim',
  require 'custom.plugins.dap',
  require 'custom.plugins.gitsigns',
  require 'custom.plugins.indent-blankline',
  require 'custom.plugins.lsp',
  require 'custom.plugins.lualine',
  require 'custom.plugins.neoterm',
  require 'custom.plugins.nvim-cmp',
  require 'custom.plugins.nvim-tree',
  require 'custom.plugins.file-ops', --> Needs to be loaded after nvim-tree
  require 'custom.plugins.telescope',
  require 'custom.plugins.treesitter',
}
