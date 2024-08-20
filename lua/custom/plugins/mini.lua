local map = require('custom.helpers').map
map('n', '<leader>ls', ':lua require("mini.sessions").read()<CR>', 'Load [l]ast [s]ession')
map('n', '<leader>zz', ':lua require("mini.misc").zoom()<CR>', '[Z]oom current buffer')

return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    require('mini.sessions').setup {
      -- Whether to read latest session if Neovim opened without file arguments
      autoread = false,

      -- Whether to write current session before quitting Neovim
      autowrite = true,

      -- File for local session (use `''` to disable)
      file = 'Session.vim',

      -- Whether to force possibly harmful actions (meaning depends on function)
      force = { read = false, write = true, delete = false },

      -- -- Hook functions for actions. Default `nil` means 'do nothing'.
      -- hooks = {
      --   -- Before successful action
      --   pre = { read = nil, write = nil, delete = nil },
      --   -- After successful action
      --   post = { read = nil, write = nil, delete = nil },
      -- },

      -- Whether to print session path after action
      verbose = { read = true, write = false, delete = true },
    }

    require('mini.bracketed').setup {}
    require('mini.jump2d').setup()
  end,
}
