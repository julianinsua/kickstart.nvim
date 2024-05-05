return {
  'windwp/nvim-autopairs',
  dependencies = { 'hrsh7th/nvim-cmp' },
  event = 'InsertEnter',
  config = function()
    local autopairs = require 'nvim-autopairs'
    autopairs.setup {
      check_ts = true,
      ts_config = {
        lua = { 'string' }, --> Don't add pairs on lua strings
        javascript = { 'template_string' }, --> Don't add pairs on js in TS's template string nodes
        java = false, --> Don't check treesitter on java
      },
    }

    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    local cmp = require 'cmp'
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}
