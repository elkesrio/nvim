local map = require('custom.helpers').map

return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for install instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    {
      'nvim-telescope/telescope-live-grep-args.nvim',
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = '^1.0.0',
    },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of help_tags options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    local actions = require 'telescope.actions'
    local lga_actions = require 'telescope-live-grep-args.actions'
    local live_grep_args_shortcuts = require 'telescope-live-grep-args.shortcuts'

    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      defaults = {
        layout_config = { scroll_speed = 1 },
        history = {
          path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
          limit = 100,
        },
        cache_picker = { num_pickers = 10, limit_entries = 100 },
        mappings = {
          i = {
            ['<C-n>'] = actions.cycle_history_next,
            ['<C-p>'] = actions.cycle_history_prev,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-a>'] = actions.select_all,
            ['<a-k>'] = actions.preview_scrolling_up,
            ['<a-j>'] = actions.preview_scrolling_down,
            ['<c-d>'] = actions.delete_buffer,
          },
          n = {
            ['c-d'] = actions.delete_buffer,
            ['q'] = actions.close,
          },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        live_grep_args = {
          auto_quoting = true, -- enable/disable auto-quoting
          -- define mappings, e.g.
          mappings = { -- extend mappings
            i = {
              ['<C-q>'] = lga_actions.quote_prompt(),
            },
          },
          -- ... also accepts theme settings, for example:
          -- theme = "dropdown", -- use dropdown theme
          -- theme = { }, -- use own theme spec
          -- layout_config = { mirror=true }, -- mirror preview pane
        },
      },
    }

    -- Enable telescope extensions, if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'smart_history')
    pcall(require('telescope').load_extension, 'live_grep_args')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    local function files_in_directory(prompt, cwd)
      return function()
        require('telescope.builtin').find_files {
          prompt_title = prompt,
          cwd = cwd,
        }
      end
    end

    map('n', '<leader>fh', builtin.help_tags, '[F]ind [H]elp')
    map('n', '<leader>fk', builtin.keymaps, '[F]ind [K]eymaps')
    map('n', '<leader>ff', builtin.find_files, '[F]ind [F]iles')
    map('n', '<leader>fd', function()
      builtin.find_files { hidden = true, no_ignore = true }
    end, '[F]ind including [D]ot files')
    map('n', '<leader>fs', builtin.builtin, '[F]ind [S]elect Telescope')
    map('n', '<leader>fw', live_grep_args_shortcuts.grep_word_under_cursor, '[F]ind current [W]ord')
    map('v', '<leader>fg', live_grep_args_shortcuts.grep_visual_selection, '[F]ind [G]rep selection')
    map('n', '<leader>fg', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", '[F]ind by [G]rep with args')
    map('n', '<leader>fm', builtin.git_status, '[F]ind in git [M]odified files')
    map('n', '<leader>fp', builtin.pickers, '[F]ind your different [p]ickers seach history')
    map('n', '<leader>fr', builtin.resume, '[F]ind [R]esume')
    map('n', '<leader>fq', builtin.quickfixhistory, '[F]ind [Q]uickfix')
    map('n', '<leader>fc', '<cmd>Telescope neoclip<CR>', '[F]ind [C]lipboard history')
    map('n', '<leader>fam', files_in_directory('< Models >', 'app/models'), '[F]ind [A]pp [M]odels')
    map('n', '<leader>fag', files_in_directory('< Graphql >', 'app/graphql'), '[F]ind [A]pp [G]raphql')

    map('n', '<leader>f.', function()
      builtin.oldfiles { only_cwd = true }
    end, '[F]ind Recent Files ("." for repeat)')
    map('n', '<leader><leader>', function()
      builtin.buffers { only_cwd = true, sort_lastused = true, ignore_current_buffer = true, sort_mru = true }
    end, '[F]ind existing buffers')

    -- Slightly advanced example of overriding default behavior and theme
    map('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, '[/] Fuzzily search in current buffer')

    -- Also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    map('n', '<leader>f/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, '[F]ind [/] in Open Files')

    -- Shortcut for searching your neovim configuration files
    map('n', '<leader>fn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, '[F]ind [N]eovim files')
  end,
}
