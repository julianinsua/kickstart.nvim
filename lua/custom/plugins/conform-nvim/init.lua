return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      typescript = { 'prettier' },
      javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'prettier' },
      css = { 'prettierd', 'prettier', stop_after_first = true },
      html = { 'prettierd', 'prettier', stop_after_first = true },
      json = { 'prettierd', 'prettier', stop_after_first = true },
      yaml = { 'prettierd', 'prettier', stop_after_first = true },
      markdown = { 'prettierd', 'prettier', stop_after_first = true },
      graphql = { 'prettierd', 'prettier', stop_after_first = true },
      python = { 'isort', 'black' },
      java = { 'google-java-format' },
    },

    formatters = {
      google_java_format = {
        command = vim.fn.expand '~/.local/share/nvim-kickstart/mason/packages/google-java-format/google-java-format',
      },
      prettier = {
        options = {
          -- Use a specific prettier parser for a filetype
          -- Otherwise, prettier will try to infer the parser from the file name
          ft_parsers = {
            --     javascript = "babel",
            --     javascriptreact = "babel",
            typescript = 'typescript',
            typescriptreact = 'typescript',
            --     vue = "vue",
            --     css = "css",
            --     scss = "scss",
            --     less = "less",
            --     html = "html",
            --     json = "json",
            --     jsonc = "json",
            --     yaml = "yaml",
            --     markdown = "markdown",
            --     ["markdown.mdx"] = "mdx",
            --     graphql = "graphql",
            --     handlebars = "glimmer",
          },
          -- Use a specific prettier parser for a file extension
          ext_parsers = {
            -- qmd = "markdown",
          },
        },
      },
    },
  },
}
