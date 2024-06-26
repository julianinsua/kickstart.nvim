local lsputil = require 'lspconfig.util'
local autocmds = require 'custom.plugins.lsp.gopls.autocmd'

local create_go_test_file = function()
  print 'creating test files'
  -- Get the current file name
  local current_file = vim.api.nvim_buf_get_name(0)

  -- Check if the current file is a Go file
  if vim.fn.empty(current_file) == 1 or not current_file:match '%.go$' then
    print 'Current file is not a Go file'
    return
  end

  -- Create a new file name for the test file
  local test_file = current_file:gsub('%.go$', '_test.go')

  -- Check if the test file already exists
  if vim.fn.filereadable(test_file) == 1 then
    print('Test file already exists: ' .. test_file)
    return
  end

  -- Create the new test file and open it
  vim.cmd('e ' .. test_file)

  -- Insert basic testing method template
  vim.api.nvim_buf_set_lines(0, 0, -1, false, {
    'package ' .. vim.fn.fnamemodify(current_file, ':h:t'),
    '',
    'import (',
    '\t"testing"',
    ')',
    '',
    'func Test(t *testing.T) {',
    '\t// Your test code here',
    '}',
  })

  print('Test file created: ' .. test_file)
end

return {
  on_attach = function(client, bufnr)
    vim.api.nvim_create_user_command('GoCreateTestFile', autocmds.create_go_test_file, {})
    vim.api.nvim_create_user_command('GoLiveTest', function()
      autocmds.attach_cmd_to_buffer(vim.api.nvim_get_current_buf(), { 'go', 'test', './...', '-v', '-json' })
    end, {})
    -- vim.keymap.set('n', '<leader><M-l>', '<cmd>Lspsaga outline<cr>', { noremap = true, silent = false, buffer = bufnr, desc = 'Show file out[L]ine' })
  end,
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_dir = lsputil.root_pattern('go.work', 'go.mod', '.git'),
  settings = {
    gopls = {
      completeUnimported = true,
    },
  },
}
