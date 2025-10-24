--[[
# MIT License
#
# Copyright (c) 2025 Mickaël Canouil
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
]]

--- Extension name constant
local EXTENSION_NAME = 'collapse-output'

--- Load utils module
local utils = require(quarto.utils.resolve_path('_modules/utils.lua'):gsub('%.lua$', ''))

--- @type string The method to use for collapsing output (lua or javascript)
local method = 'lua'


--- Get configuration from metadata
--- This function extracts the configuration options from document metadata
--- @param meta table The document metadata table
--- @return table The metadata table (unchanged)
local function get_configuration(meta)
  local meta_method = utils.get_metadata_value(meta, 'collapse-output', 'method')

  -- Set method
  if not utils.is_empty(meta_method) then
    method = (meta_method --[[@as string]]):lower()
    if method ~= 'lua' and method ~= 'javascript' then
      utils.log_warning(EXTENSION_NAME, 'Invalid method \'' .. method .. '\'. Using default \'lua\'.')
      method = 'lua'
    end
  else
    method = 'lua' -- default method
  end

  return meta
end

--- Process Div elements to add collapse functionality.
--- Wraps cell output in collapsible <details> elements when output-fold="true".
--- Supports both Lua-based (server-side) and JavaScript-based (client-side) methods.
---
--- @param div pandoc.Div The Div element to process
--- @return pandoc.Div|nil The modified Div or nil if no changes
local function process_div(div)
  if not quarto.doc.is_format('html') then
    return nil
  end

  if div.attributes['output-fold'] ~= 'true' then
    return nil
  end

  --- @type string Summary text for the collapsible section
  local summary_text = div.attributes['output-summary'] or 'Code Output'

  if method == 'lua' then
    -- Process with Lua (server-side rendering)
    --- @type table<integer, table> New content with wrapped output blocks
    local new_content = {}

    for _, block in ipairs(div.content) do
      if block.t == 'Div' then
        --- @type boolean Flag indicating if block is cell output
        local has_cell_output = false
        has_cell_output = block.classes:find('cell-output') or
          block.classes:find('cell-output-stdout') or
          block.classes:find('cell-output-display')

        if has_cell_output then
          table.insert(new_content, pandoc.RawBlock('html', '<details><summary>' .. summary_text .. '</summary>'))
          table.insert(new_content, block)
          table.insert(new_content, pandoc.RawBlock('html', '</details>'))
        else
          table.insert(new_content, block)
        end
      else
        table.insert(new_content, block)
      end
    end

    div.content = new_content
    return div
  elseif method == 'javascript' then
    -- Use utils module to ensure HTML dependencies
    if method == 'javascript' then
      utils.ensure_html_dependency({
        name = 'collapse-output',
        version = '1.0.0',
        scripts = {
          { path = 'collapse-output.min.js', afterBody = true }
        }
      })
    end
    return div
  else
    return nil
  end
end

--- Pandoc filter configuration.
--- Defines the order of filter execution:
--- 1. Get configuration from metadata
--- 2. Process Div elements for collapse functionality
--- @type table
return {
  { Meta = get_configuration },
  { Div = process_div }
}
