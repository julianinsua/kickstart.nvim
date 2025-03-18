local ls = require 'luasnip'
local s = ls.snippet
local f = ls.function_node

return {
  s(
    { trig = 'selected_text', description = 'do somtehing easy to prove a point' },
    f(function(args, snip)
      local res, env = {}, snip.env
      table.insert(res, 'Selected Text (current line is ' .. env.TM_LINE_NUMBER .. '):')
      for _, ele in ipairs(env.LS_SELECT_RAW) do
        table.insert(res, ele)
      end
      return res
    end, {})
  ),
}
