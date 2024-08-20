local map = require('custom.helpers').map

return {
  'vim-test/vim-test',
  dependencies = {
    'preservim/vimux',
  },
  map('n', '<leader>tn', ':TestNearest<CR>', '[Vim-Test] [t]est the nearest test'),
  map('n', '<leader>T', ':TestFile<CR>', '[Vim-Test] [T]est the current file'),
  map('n', '<leader>tl', ':TestLast<CR>'),
  map('n', '<leader>tv', ':TestVisit<CR>'),
  map('n', '<leader>vc', ':VimuxCloseRunner<CR>', '[V]imux [C]lose runner'),
  map('n', '<leader>vv', ':VimuxZoomRunner<CR>', '[V]imux zoom runner'),
  vim.cmd "let test#strategy = 'vimux'",
  vim.cmd 'let g:VimuxUseNearest = 0',
  vim.cmd [[function! VimuxSlime()
    call VimuxRunCommand(@v)
   endfunction]],
  map('v', '<leader>vs', '"vy :call VimuxSlime()<CR>', '[V]imux [S]lime'),
}
