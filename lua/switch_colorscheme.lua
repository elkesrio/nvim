local map = require('custom.helpers').map

-- Define the array of colorschemes
local colorschemes = { 'catppuccin-mocha', 'catppuccin-macchiato', 'catppuccin-frappe' }
-- Variable to keep track of the current colorscheme index
local current_index = 1

-- Function to switch to the next colorscheme
local function switch_colorscheme()
  -- Increment the index
  current_index = current_index % #colorschemes + 1
  -- Set the colorscheme
  vim.cmd('colorscheme ' .. colorschemes[current_index])
  -- Print a message to show the current colorscheme
  print('Switched to colorscheme: ' .. colorschemes[current_index])
end

-- Set up a keybinding to call the switch_colorscheme function
map('n', '<leader>sc', switch_colorscheme, '[S]witch [c]olorscheme')
