local M = {}

M.setup = function()
  local jdtls = require 'jdtls'
  local jdtls_dap = require 'jdtls.dap'
  local jdtls_setup = require 'jdtls.setup'

  local root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }
  local root_dir = jdtls_setup.find_root(root_markers)
  local mason_path = vim.fn.expand '~/.local/share/nvim-kickstart/mason/packages'
  local jdtls_path = mason_path .. '/jdtls'
  local jdebug_path = mason_path .. '/java-debug-adapter'
  local jtest_path = mason_path .. '/java-test'

  local config_path = jdtls_path .. '/config_linux'
  local lombok_path = jdtls_path .. '/lombok.jar'
  local jar_path = jdtls_path .. '/plugins/org.eclipse.equinox.launcher_1.6.700.v20231214-2017.jar'

  local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
  local ws_path = vim.fn.expand '~/.cache/jdtls/workspace' .. project_name

  local bundles = {
    vim.fn.glob(jdebug_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar', 1),
  }

  vim.list_extend(bundles, vim.split(vim.fn.glob(jtest_path .. '/extension/server/*.jar', true), '\n'))

  -- LSP settings for Java.
  local on_attach = function(_, bufnr)
    jdtls.setup_dap { hotcodereplace = 'auto' }
    jdtls_dap.setup_dap_main_class_configs()

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
      vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })

    -- NOTE: Comment out if you don't use lsp-signature
    -- require('lsp_signature').on_attach({
    --   bind = true,
    --   padding = '',
    --   handler_opts = {
    --     border = 'rounded',
    --   },
    --   hint_prefix = '󱄑 ',
    -- }, bufnr)

    -- NOTE: comment out if you don't use Lspsaga
    -- require('lspsaga').init_lsp_saga()
  end

  local capabilities = {
    workspace = {
      configuration = true,
    },
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
        },
      },
    },
  }

  local extendedClientCapabilities = require('jdtls').extendedClientCapabilities
  extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
  local config = {
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = {
      'java', -- or '/path/to/java17_or_newer/bin/java'
      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-Xmx1g',
      '-javaagent:' .. lombok_path,
      '--add-modules=ALL-SYSTEM',
      '--add-opens',
      'java.base/java.util=ALL-UNNAMED',
      '--add-opens',
      'java.base/java.lang=ALL-UNNAMED',
      '-jar',
      jar_path,
      '-configuration',
      config_path,
      '-data',
      ws_path,
    },
    root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
    settings = {
      java = {
        references = {
          includeDecompiledSources = true,
        },
        eclipse = {
          downloadSources = true,
        },
        maven = {
          downloadSources = true,
        },
        signatureHelp = { enabled = true },
        contentProvider = { preferred = 'fernflower' },
        configuration = {
          -- Search for `interface RuntimeOption` in https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
          -- WARN: The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
          runtimes = {
            {
              name = 'JavaSE-21',
              path = '/usr/lib/jvm/java-21-openjdk/',
            },
            {
              name = 'JavaSE-17',
              path = '/usr/lib/jvm/java-17-openjdk/',
            },
          },
        },
      },
    },
    flags = {
      allow_incremental_sync = true,
    },
    init_options = {
      bundles = bundles,
      extendedClientCapabilities = extendedClientCapabilities,
    },
  }

  config.on_init = function(client)
    client.notify('workspace/didChangeConfiguration', { settings = config.settings })
  end

  -- Start Server
  require('jdtls').start_or_attach(config)

  -- Set Java Specific Keymaps
  require 'custom.plugins.lsp.java.keymaps'
end

return M
