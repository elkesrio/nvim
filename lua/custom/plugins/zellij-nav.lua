local map = require('custom.helpers').map

return {
  'https://git.sr.ht/~swaits/zellij-nav.nvim',
  config = function()
    require('zellij-nav').setup()

    map('n', '<c-h>', '<cmd>ZellijNavigateLeft<cr>', 'navigate left')
    map('n', '<c-j>', '<cmd>ZellijNavigateDown<cr>', 'navigate down')
    map('n', '<c-k>', '<cmd>ZellijNavigateUp<cr>', 'navigate up')
    map('n', '<c-l>', '<cmd>ZellijNavigateRight<cr>', 'navigate right')
  end,
}
