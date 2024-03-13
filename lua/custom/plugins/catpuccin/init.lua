return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  init = function()
    vim.cmd.colorscheme 'catppuccin'
    vim.cmd.hi 'Comment gui=none'
  end,
  config = function()
    require('catppuccin').setup {
      flavour = 'mocha',
      background = {
        light = 'latte',
        dark = 'mocha',
      },
    }
  end,
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    mini = {
      enabled = true,
      indentscope_color = '',
    },
    fidget = true,
    mason = true,
    dap = true,
    dap_ui = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { 'italic' },
        hints = { 'italic' },
        warnings = { 'italic' },
        information = { 'italic' },
      },
      underlines = {
        errors = { 'underline' },
        hints = { 'underline' },
        warnings = { 'underline' },
        information = { 'underline' },
      },
      inlay_hints = {
        background = true,
      },
    },
    indent_blankline = {
      enabled = true,
      scope_color = 'lavender',
      colored_indent_levels = false,
    },
  },
}
