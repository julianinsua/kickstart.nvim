return {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  on_attach = function(client, bufnr)
    vim.keymap.set('n', '<leader><M-l>', function()
      vim.cmd 'Toc'
      vim.cmd 'vertical resize 60'
    end, { noremap = true, desc = 'Display Table of contents' })
    vim.keymap.set('n', 'gf', '<cmd>ObsidianFollowLink<cr>', { noremap = true, silent = true, buffer = bufnr, desc = '[G]o to Obsidian [F]ile' })
  end,
}
