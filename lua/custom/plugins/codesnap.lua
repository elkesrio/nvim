local map = require('custom.helpers').map
return {
  'mistricky/codesnap.nvim',
  build = 'make',
  config = function()
    require('codesnap').setup()
    map('v', '<leader>cs', ':CodeSnap<cr>', '[C]ode [s]nap preview')
  end,
}
