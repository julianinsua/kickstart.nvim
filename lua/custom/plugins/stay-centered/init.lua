return {
  'arnamak/stay-centered.nvim',
  init = function()
    vim.api.nvim_create_user_command('WriteMode', function()
      require('stay-centered').enable()
      vim.cmd 'ZenMode'
    end, {})
    vim.api.nvim_create_user_command('WriteModeOff', function()
      require('stay-centered').disable()
      vim.cmd 'ZenMode'
    end, {})
  end,
}
