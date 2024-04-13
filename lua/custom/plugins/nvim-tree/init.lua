local onAttach = function(bufnr)
  local api = require 'nvim-tree.api'

  local function opts(desc)
    return { desc = 'Nvim tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts 'Up')
  vim.keymap.set('n', '?', api.tree.toggle_help, opts 'Help')
end

return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {
      on_attach = onAttach,
      view = {
        width = 50,
      },
      renderer = {
        group_empty = true,
      },
    }
    vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<cr>')
  end,
}
