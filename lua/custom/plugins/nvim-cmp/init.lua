return { -- Autocompletion
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    {
      'L3MON4D3/LuaSnip',
      build = (function()
        -- Build Step is needed for regex support in snippets
        -- This step is not supported in many windows environments
        -- Remove the below condition to re-enable on windows
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
    },
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'rafamadriz/friendly-snippets', -- Add pre-configured snippets,
    { 'windwp/nvim-autopairs', opts = {} },
    { 'petertriho/cmp-git', dependencies = 'nvim-lua/plenary.nvim' },
  },
  config = function()
    -- See `:help cmp`
    local cmp = require 'cmp'
    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    local cmp_icons = require('custom.plugins.nvim-cmp.icons').icons
    local ls = require 'luasnip'

    ls.config.set_config {
      enable_autosnippets = true,
      store_selection_keys = '<C-Space>',
    }

    -- For a very comprehensive tutorial on snippets check:
    -- https://ejmastnak.com/tutorials/vim-latex/luasnip/#advanced-nodes
    -- Custom snippets, simple VSCode like
    require('luasnip.loaders.from_vscode').lazy_load()
    require('luasnip.loaders.from_vscode').load { paths = { './lua/custom/snippets/' } }
    -- Smart snippets using LuaSnip, Treesitter, LSP, etc.
    require('luasnip.loaders.from_lua').load { paths = { './lua/custom/snippets/from_lua' } }

    -- Get javascriptreact snippets on .js files
    ls.filetype_extend('javascript', { 'javascriptreact' })
    -- Get typescriptreact snippets on .ts files
    ls.filetype_extend('typescript', { 'typescriptreact' })

    require('cmp_git').setup()

    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

    cmp.setup {
      snippet = {
        expand = function(args)
          ls.lsp_expand(args.body)
        end,
      },
      completion = { completeopt = 'menu,menuone,noinsert' },
      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
          local kind = vim_item.kind
          local source = entry.source.name
          local item = entry:get_completion_item()
          vim_item.kind = (cmp_icons[kind] or '') .. ' ' .. '[' .. (cmp_icons[source] or 'p') .. ']'
          vim_item.menu = '(' .. kind .. ')'
          return vim_item
        end,
      },
      -- For an understanding of why these mappings were
      -- chosen, you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      mapping = cmp.mapping.preset.insert {
        ['<c-b>'] = cmp.mapping.scroll_docs(-4),
        ['<c-f>'] = cmp.mapping.scroll_docs(4),
        ['<c-e>'] = cmp.mapping.abort(),
        -- Select the next item [j]
        ['<C-j>'] = cmp.mapping.select_next_item(),
        -- Select the previous item [k]
        ['<C-k>'] = cmp.mapping.select_prev_item(),

        -- Accept ([y]es) the completion.
        -- Will auto-import if LSP supports it and will expand snippets if LSP sent a snippet.
        ['<C-Space>'] = cmp.mapping.confirm { select = true },

        -- Manually trigger a completion from nvim-cmp.
        ['<C-y>'] = cmp.mapping.complete {},

        -- <c-l> and <c-h> move to the next or previous field of your snippet.
        ['<C-l>'] = cmp.mapping(function()
          if ls.expand_or_locally_jumpable() then
            ls.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if ls.locally_jumpable(-1) then
            ls.jump(-1)
          end
        end, { 'i', 's' }),
        ['<C-u>'] = cmp.mapping(function()
          if ls.choice_active() then
            ls.change_choice(1)
          end
        end),
        ['<C-z>'] = cmp.mapping(function()
          ls.unlink_current()
        end, { 'i', 's' }),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip', option = { show_autosnippets = true } },
        { name = 'buffer' },
        { name = 'path' },
      },
    }
    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'git' }, -- You can specify the `git` source if you installed it
      }, {
        { name = 'buffer' },
      }),
    })
  end,
}
