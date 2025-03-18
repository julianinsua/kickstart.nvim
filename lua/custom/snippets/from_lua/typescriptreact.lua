local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local rep = require('luasnip.extras').rep

-- get_visual gets the text stored from a selection, if it's empty it returns an empty insert node
local get_visual = function(args, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

local fullUseEffectSnippetString = [[useEffect(() =>> {
  <> 
  return () =>> {
    <>
  } 
}, [])]]

local functionalComponentSelector = [[ [
;; Function Component (Named Function)
(
  function_declaration
    name: (identifier) @component.name
    body: (statement_block
            (return_statement (jsx_element) @component.jsx))
) @component

;; Function Component (Arrow Function Assigned to a Variable)
(
  lexical_declaration
    (variable_declarator
      name: (identifier) @component.name
      value: (arrow_function
               body: (jsx_element) @component.jsx))
) @component

(
  lexical_declaration
    (variable_declarator
      name: (identifier) @component.name
      value: (arrow_function
               body: (statement_block
                       (return_statement (jsx_element) @component.jsx))))
) @component

;; Function Component (Function Expression Assigned to a Variable)
(
  lexical_declaration
    (variable_declarator
      name: (identifier) @component.name
      value: (function_expression
               body: (statement_block
                       (return_statement (jsx_element) @component.jsx))))
) @component
] ]]

vim.treesitter.query.set('tsx', 'query_in_component', functionalComponentSelector)

local testing_function = function()
  local query = vim.treesitter.query.get('typescript', 'query_in_component')
  vim.print(query)
  return (t(query))
end

return {
  s({ trig = 'cbw', description = 'Wrap a selected function in a useCallback hook' }, fmta([[useCallback(<>, [])]], { d(1, get_visual) })),
  s({ trig = 'mmw', description = 'Wrap a selected function in a useMemo hook' }, fmta([[useMemo(() =>> <>, [])]], { d(1, get_visual) })),
  s(
    {
      trig = 'uef',
      description = 'Create a sidefect using the useEffect hook',
    },
    c(1, {
      sn(nil, fmta([[useEffect(() =>> {<>}, [])]], { i(1) })),
      sn(nil, fmta(fullUseEffectSnippetString, { i(1, 'onDepChange'), i(2, 'onUnmount') })),
    })
  ),
  s(
    { trig = 'tgv', description = 'Create a new Typescript React component', snippetType = 'autosnippet' },
    fmta(
      [[import React from "react"
import type { FC } from "react"

type PropTypes = {}

const <>: FC<<PropTypes>> = ({}) =>> {
  return (
    <<div>>
      <>
    <</div>>
  )
}

<>.defaultProps = {}

export default <>
  ]],
      {
        d(1, function(args, parent)
          if parent.snippet.TM_FILENAME_BASE then
            return i(nil, parent.snippet.TM_FILENAME_BASE)
          end
          return i(nil, 'ComponentName')
        end),
        rep(1),
        rep(1),
        rep(1),
      }
    )
  ),
  -- s({ trig = 'testsnip' }, fmta([[testing <>]], d(1, testing_function))),
}
