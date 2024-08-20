local map = require('custom.helpers').map
local harpoon = require 'harpoon'

-- Navigation
map('i', 'kj', '<ESC>', 'Map kj to ESC in normal mode')
map('i', 'jk', '<ESC>', 'Map kj to ESC in normal mode')
map('n', '<leader><CR>', '<cmd>nohlsearch<CR>')
map('n', 'L', '$', 'Move to the end of the line')
map('v', 'L', '$', 'Move to the end of the line')
map('n', '0', '^', 'Move to the first non-blank character of the line')
map('n', '<a-j>', '<cmd>m+1<cr>', 'Move the current line down')
map('n', '<a-k>', '<cmd>m-2<cr>', 'Move the current line up')

-- Buffers management
map('n', '<leader>bd', '<cmd>bp|bd#<cr>', 'Close the current buffer')

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, 'Go to previous [D]iagnostic message')
map('n', ']d', vim.diagnostic.goto_next, 'Go to next [D]iagnostic message')
map('n', '<leader>e', vim.diagnostic.open_float, 'Show diagnostic [E]rror messages')
map('n', '<leader>q', vim.diagnostic.setloclist, 'Open diagnostic [Q]uickfix list')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- TODO: Fix this ?!
map('t', '<Esc><Esc>', '<C-\\><C-n>', 'Exit terminal mode')

-- map <C-s> to save the current file
map('n', '<leader>s', '<cmd>write<CR>', 'Save the current file')
map('n', '<leader>S', ':wa<CR>', 'Save all buffers')
map('i', '<C-s>', '<cmd>write<CR>', 'Save the current file')

-- map ]q and [q to navigate the quickfix list
map('n', ']q', '<cmd>cnext<CR>', 'Go to the next item in the quickfix list')
map('n', '[q', '<cmd>cprev<CR>', 'Go to the previous item in the quickfix list')
map('n', '<leader>qc', '<cmd>cclose<CR>', 'Close the quickfix list')

map('x', 'Q', ':norm @q<CR>', 'Replay the last recorded macro in visual mode')
map('n', 'Q', '@qj', 'Replay the last recorded macro in normal mode and go to next line')

local function close_all_buffers_and_clear_harpoon()
  local buffers = vim.api.nvim_list_bufs()
  for _, buf in ipairs(buffers) do
    if vim.api.nvim_buf_is_loaded(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end

  harpoon:list():clear()
end
map('n', '<leader>C', close_all_buffers_and_clear_harpoon, '[C]lear buffers and harpoons')
