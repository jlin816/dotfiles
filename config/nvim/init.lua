-- Source .vimrc
vim.cmd('source ~/.vimrc')

-- Lua-based plugin configurations can follow here
require('treesitter-context').setup{
  max_lines = 3,
  min_window_height = 0,
  line_numbers = true,
  multiline_threshold = 3,
  trim_scope = 'outer',
  mode = 'cursor',
  separator = nil,
  zindex = 20,
  on_attach = nil,
}
