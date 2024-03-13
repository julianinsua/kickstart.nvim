local function add_trailing_comma_on_new_line()
  local line = vim.api.nvim_get_current_line()
  local should_add_comma = string.find(line, '[^,{[]$')

  if should_add_comma then
    return 'A,<cr>'
  else
    return 'o'
  end
end

return {
  capabilities = {
    textDocument = {
      completionItem = {
        snippetSupport = true,
      },
    },
  },
  on_attach = function()
    vim.keymap.set('n', 'o', add_trailing_comma_on_new_line, { buffer = true, expr = true })
  end,
}
