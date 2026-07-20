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

-- Keep LSP popovers from stealing focus.
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { focusable = false, border = "rounded" }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { focusable = false, border = "rounded" }
)
