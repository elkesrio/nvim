return {
  'lewis6991/gitsigns.nvim',
  event = 'VimEnter',
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
  },
  config = function()
    require('gitsigns').setup {}

    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']h', function()
      if vim.wo.diff then
        return ']c'
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return '<Ignore>'
    end, { expr = true })

    map('n', '[h', function()
      if vim.wo.diff then
        return '[c'
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return '<Ignore>'
    end, { expr = true })

    -- Actions
    map({ 'n', 'v' }, '<leader>gs', ':Gitsigns stage_hunk<CR>', { desc = '[Gitsigns] [s]tage' })
    map({ 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk<CR>', { desc = '[Gitsigns] [r]eset' })
    map('n', '<leader>gS', gs.stage_buffer, { desc = '[Gitsigns] [S]tage buffer' })
    map('n', '<leader>gu', gs.undo_stage_hunk, { desc = '[Gitsigns] [u]ndo stage' })
    map('n', '<leader>gR', gs.reset_buffer, { desc = '[Gitsigns] [R]eset buffer' })
    map('n', '<leader>gp', gs.preview_hunk, { desc = '[Gitsigns] [p]review hunk' })
    map('n', '<leader>gb', function()
      gs.blame_line { full = true }
    end, { desc = '[Gitsigns] [b]lame' })
    map('n', '<leader>gtb', gs.toggle_current_line_blame, { desc = '[Gitsigns] [t]oggle [b]lame' })
    map('n', '<leader>gd', gs.diffthis, { desc = '[Gitsigns] [d]iff' })
    map('n', '<leader>gD', function()
      gs.diffthis '~'
    end, { desc = '[Gitsigns] [D]iff' })
    map('n', '<leader>gtd', gs.toggle_deleted, { desc = '[Gitsigns] toggle [d]eleted' })

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end,
}
