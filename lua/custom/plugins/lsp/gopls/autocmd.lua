local M = {}

local ns = vim.api.nvim_create_namespace 'go-live-testing'
local group = vim.api.nvim_create_augroup('attach_cmd_to_buffer', { clear = true })

local test_function_query_string = [[
(
  (function_declaration
    name: (identifier)  @name
    parameters:
      (parameter_list
      (parameter_declaration
        name: (identifier)
        type: (pointer_type
          (qualified_type
            package: (package_identifier) @_package_name
            name: (type_identifier) @_type_name)))))
  (#eq? @_package_name "testing")
  (#eq? @_type_name "T")
  (#eq? @name "%s")
)
]]

local find_test_line = function(go_bufnr, name)
  local formatted = string.format(test_function_query_string, name)
  local query = vim.treesitter.query.parse('go', formatted)
  local parser = vim.treesitter.get_parser(go_bufnr, 'go', {})
  local tree = parser:parse()[1]
  local root = tree:root()

  for id, node in query:iter_captures(root, go_bufnr, 0, -1) do
    print(id)
    print(vim.inspect(node))
    if id == 1 then
      local range = { node:range() }
      return range[1]
    end
  end
end

local make_key = function(entry)
  assert(entry.Package, 'Must have Package:' .. vim.inspect(entry))
  assert(entry.Test, 'Must have Test:' .. vim.inspect(entry))
  return (string.format('%s/%s', entry.Package, entry.Test))
end

local add_golang_test = function(state, entry)
  state.tests[make_key(entry)] = {
    name = entry.Test,
    line = find_test_line(state.bufnr, entry.Test),
    output = {},
  }
end

local add_golang_output = function(state, entry)
  assert(state.tests, vim.inspect(state))
  table.insert(state.tests[make_key(entry)].output, vim.trim(entry.Output))
end

local mark_success = function(state, entry)
  state.tests[make_key(entry)].success = entry.Action == 'pass'
end

M.attach_cmd_to_buffer = function(bufnr, cmd)
  local state = {
    bufnr = bufnr,
    tests = {},
  }
  vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('attach_cmd_to_buffer', { clear = true }),
    pattern = '*.go',
    callback = function()
      vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

      vim.fn.jobstart(cmd, {
        stdout_buffered = true,
        on_stdout = function(_, data)
          if not data then
            return
          end

          for _, line in ipairs(data) do
            local decoded = vim.json.decode(line)
            print(vim.inspect(decoded))
            if decoded.Action == 'run' then
              add_golang_test(state, decoded)
            elseif decoded.Action == 'output' then
              if not decoded.Test then
                return
              end

              add_golang_output(state, decoded)
            elseif decoded.Action == 'pass' or decoded.Action == 'fail' then
              mark_success(state, decoded)

              local test = state.test[make_key(decoded)]
              if test.success then
                local text = { 'Test passed' }
                vim.api.nvim_buf_set_extmark(bufnr, ns, test.line, 0, {
                  virt_text = { text },
                })
              end
            elseif decoded.Action == 'pause' or decoded.Action == 'cont' or decoded.Action == 'start' then
              -- Do nothing
            else
              error('Failed to handle' .. vim.inspect(data))
            end
          end
        end,
        on_exit = function()
          local failed = {}
          for _, test in pairs(state.tests) do
            if test.line then
              if not test.success then
                table.insert(failed, {
                  bufnr = bufnr,
                  lnum = test.line,
                  col = 0,
                  severity = vim.diagnostics.severity.ERROR,
                  source = 'go-live-test',
                  message = 'Test failed',
                  user_data = {},
                })
              end
            end
          end

          vim.diagnostic.set(ns, bufnr, failed or {}, {})
        end,
      })
    end,
  })
end

M.create_go_test_file = function()
  print 'creating test files'
  -- Get the current file name
  local current_file = vim.api.nvim_buf_get_name(0)

  -- Check if the current file is a Go file
  if vim.fn.empty(current_file) == 1 or not current_file:match '%.go$' then
    print 'Current file is not a Go file'
    return
  end

  -- Create a new file name for the test file
  local test_file = current_file:gsub('%.go$', '_test.go')

  -- Check if the test file already exists
  if vim.fn.filereadable(test_file) == 1 then
    print('Test file already exists: ' .. test_file)
    return
  end

  -- Create the new test file and open it
  vim.cmd('e ' .. test_file)

  -- Insert basic testing method template
  vim.api.nvim_buf_set_lines(0, 0, -1, false, {
    'package ' .. vim.fn.fnamemodify(current_file, ':h:t'),
    '',
    'import (',
    '\t"testing"',
    ')',
    '',
    'func Test(t *testing.T) {',
    '\t// Your test code here',
    '}',
  })

  print('Test file created: ' .. test_file)
end

return M
