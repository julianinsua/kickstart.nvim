-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Autocommand to set up the eclipse java lsp on every java file.
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Set up jdtls language server on every buffer',
  group = vim.api.nvim_create_augroup('jdtls_lsp', { clear = true }),
  pattern = 'java',
  callback = function()
    require('custom.plugins.lsp.java').setup()
  end,
})
