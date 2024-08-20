local map = require('custom.helpers').map

return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'

    harpoon:setup {
      settings = {
        key = function()
          return vim.loop.cwd()
        end,
      },
    }

    -- basic telescope configuration
    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      local finder = function()
        local paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(paths, item.value)
        end

        return require('telescope.finders').new_table {
          results = paths,
        }
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
          attach_mappings = function(prompt_bufnr, telescope_map)
            telescope_map('i', '<C-d>', function()
              local state = require 'telescope.actions.state'
              local selected_entry = state.get_selected_entry()
              local current_picker = state.get_current_picker(prompt_bufnr)

              table.remove(harpoon_files.items, selected_entry.index)
              current_picker:refresh(finder())
            end)
            return true
          end,
        })
        :find()
    end

    map('n', '<leader>fa', function()
      toggle_telescope(harpoon:list())
    end, '[F]ind h[a]rpoon')

    map('n', '<leader>aa', function()
      harpoon:list():add()
    end, 'H[a]rpoon [a]dd')
    map('n', '<leader>al', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, 'H[a]rpoon [l]ist')
    -- map('n', '<leader>')
    map('n', '[a', function()
      harpoon:list():prev { ui_nav_wrap = true }
    end, 'H[a]rpoon [p]rev')
    map('n', ']a', function()
      harpoon:list():next { ui_nav_wrap = true }
    end, 'H[a]rpoon [n]ext')
    map('n', '<leader>ac', function()
      harpoon:list():clear()
    end, 'H[a]rpoon [c]lear')
  end,
}
