local map = require('custom.helpers').map

map('n', '-', '<CMD>Oil<CR>', '[Oil] Open parent directory')
map('n', '<leader>of', ":lua require('oil').toggle_float()<CR>", '[Oil] Toggle floating window')

return {
  'stevearc/oil.nvim',
  opts = {
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    keymaps = {
      ['?'] = 'actions.show_help',
      ['q'] = 'actions.close',
    },
    sort = {
      { 'name', 'asc' },
      { 'type', 'asc' },
    },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
