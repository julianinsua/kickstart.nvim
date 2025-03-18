return { -- linting using language specific linters
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'
    lint.linters_by_ft = {
      c = { 'cpplint' },
      cpp = { 'cpplint' },
      javascript = { 'eslint', 'eslint_d' },
      typescript = { 'eslint', 'eslint_d' },
      javascriptreact = { 'eslint', 'eslint_d' },
      typescriptreact = { 'eslint', 'eslint_d' },
      -->  TODO: golangci-lint is not playing nice with mason, need to fix that.
      --> I installed the AUR package, but would much rather use Mason to handle it.
      go = { 'golangcilint' },
      python = { 'pylint' },
    }

    lint.linters.eslint_d = {
      cmd = vim.fn.expand '~/.local/share/nvim/mason/bin/eslint_d',
      args = {
        '--jsx',
        '--no-warn-ignored', -- <-- this is the key argument
        '--format',
        'json',
        '--stdin',
        '--stdin-filename',
        function()
          return vim.api.nvim_buf_get_name(0)
        end,
      },
    }

    vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
