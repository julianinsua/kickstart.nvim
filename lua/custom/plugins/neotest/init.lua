local configDiagnosticsGolang = function()
  -- get neotest namespace (api call creates or returns namespace)
  local neotest_ns = vim.api.nvim_create_namespace 'neotest'
  vim.diagnostic.config({
    virtual_text = {
      format = function(diagnostic)
        local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
        return message
      end,
    },
  }, neotest_ns)
end

return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-go',
    'marilari88/neotest-vitest',
    'nvim-neotest/neotest-jest',
  },
  config = function()
    configDiagnosticsGolang()

    require('neotest').setup {
      adapters = {
        require 'neotest-go',
        require 'neotest-vitest' {
          -- Filter directories when searching for test files. Useful in large projects (see Filter directories notes).
          filter_dir = function(name, rel_path, root)
            return name ~= 'node_modules'
          end,
        },
        require 'neotest-jest' {
          jestCommand = 'npm test --',
          jestConfigFile = 'custom.jest.config.ts',
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        },
      },
    }

    --> Add Keymaps
    vim.keymap.set('n', '<leader>tf', function()
      require('neotest').run.run(vim.fn.expand '%')
    end, { desc = '[T]est [F]ile' })
    vim.keymap.set('n', '<leader>ta', function()
      require('neotest').run.run(vim.uv.cwd())
    end, { desc = '[T]est [A]ll' })
    vim.keymap.set('n', '<leader>tn', function()
      require('neotest').run.run()
    end, { desc = '[T]est [N]earest' })
    vim.keymap.set('n', '<leader>tl', function()
      require('neotest').run.run_last()
    end, { desc = '[T]est: [L]ast Runned' })
    vim.keymap.set('n', '<leader>ts', function()
      require('neotest').summary.toggle()
    end, { desc = 'Toggle [T]est [S]ummary' })
    vim.keymap.set('n', '<leader>to', function()
      require('neotest').output.open { enter = true, auto_close = true }
    end, { desc = 'Show [T]est [O]utput' })
    vim.keymap.set('n', '<leader>tO', function()
      require('neotest').output_panel.toggle()
    end, { desc = 'Toggle [T]est [O]utput Panel' })
    vim.keymap.set('n', '<leader>tS', function()
      require('neotest').run.stop()
    end, { desc = '[T]est [S]top' })
  end,
}
