return { -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    -- Useful status updates for LSP.
    {
      'j-hui/fidget.nvim',
      opts = {
        notification = {
          window = {
            winblend = 0,
          },
        },
      },
    },
    'mfussenegger/nvim-jdtls',
  },
  config = function()
    --  This function gets run when an LSP attaches to a particular buffer.
    --    That is to say, every time a new file is opened that is associated with
    --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
    --    function will be executed to configure the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition') -- Jump back with <C-t>.
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation') --  Useful when you declare types without an actual implementation.
        map('gt', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        map('<leader>ssds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols') -- Fuzzy find variables, functions, types, etc. in your current document.
        map('<leader>ssw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols') --  Similar to document symbols, except searches over your whole project.
        map('<leader>cr', vim.lsp.buf.rename, '[R]e[n]ame') -- Rename variable. LSPs support renaming across files, etc.
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        map('<leader>cd', vim.diagnostic.goto_next, '[C]ode [d]iagnostics next')
        map('<leader>cD', vim.diagnostic.goto_prev, '[C]ode [d]iagnostics prev')
        map('<leader>ce', vim.diagnostic.open_float, '[C]ode [e]rror hover')
        map('<leader>cE', vim.diagnostic.setloclist, '[C]ode [E]rror quickfix list')
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        --
        -- -- WARN: This is not Goto Definition, this is Goto Declaration.
        -- --  For example, in C this would take you to the header
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    -- Enable the following language servers
    --  Add any additional override configuration in the following tables. Available keys are:
    --  - cmd (table): Override the default command used to start the server
    --  - filetypes (table): Override the default list of associated filetypes for the server
    --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
    --  - settings (table): Override the default settings passed when initializing the server.
    local servers = {
      -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
      lua_ls = {
        settings = {
          Lua = require 'custom.plugins.lsp.lua_ls',
        },
      },
      bashls = {},
      gopls = require 'custom.plugins.lsp.gopls',
      golangci_lint_ls = {},
      pyright = {},
      pylint = {},
      black = {},
      isort = {},
      tsserver = require 'custom.plugins.lsp.tsserver',
      cssls = {},
      cssmodules_ls = {},
      eslint_d = {},
      prettierd = {},
      prettier = {},
      jsonls = require 'custom.plugins.lsp.jsonls',
      remark_ls = require 'custom.plugins.lsp.remark_ls',
      jdtls = {},
    }

    require('mason').setup()

    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua', -- Used to format lua code
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      automatic_installation = true,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
        ['jdtls'] = function()
          -- require('custom.plugins.lsp.java').setup()
        end,
      },
    }
  end,
}
