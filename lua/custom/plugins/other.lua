local map = require('custom.helpers').map
local mappings = {
  {
    -- generic test mapping for rspec
    pattern = '/app/(.*)/(.*).rb',
    target = {
      { context = 'test', target = '/spec/%1/%2_spec.rb' },
    },
  },
  {
    pattern = '/app/interactors/(.*).rb',
    target = {
      { context = 'mutation', target = '/app/graphql/mutations/%1.rb' },
    },
  },
  {
    pattern = '/app/graphql/mutations/(.*).rb',
    target = {
      { context = 'interactor', target = '/app/interactors/%1.rb' },
    },
  },
  {
    pattern = '/lib/(.*).rb',
    target = {
      { context = 'test', target = '/spec/lib/%1_spec.rb' },
    },
  },
  {
    pattern = '/app/models/(.*).rb',
    target = {
      { context = 'model', target = '/app/models/%1.rb', transformer = 'singularize' },
      { context = 'factories', target = '/spec/factories/%1.rb', transformer = 'pluralize' },
    },
  },

  -- going back to source from tests
  {
    pattern = '/spec/(.*)/(.*)_spec.rb',
    target = {
      { target = '/app/%1/%2.rb' },
    },
  },
  {
    pattern = '/spec/lib/(.*)/(.*)_spec.rb',
    target = {
      { target = '/lib/%1/%2.rb' },
    },
  },
}

map('n', '<leader>a', '<cmd>Other<CR>', '[Other] Open alternate files')
map('n', '<leader>va', '<cmd>OtherVSplit<CR>', '[Other] Open alternate files in a [V]ertical split')
map('n', '<leader>xa', '<cmd>OtherSplit<CR>', '[Other] Open alternate files in a [H]orizontal split')

return {
  'rgroli/other.nvim',
  config = function()
    require('other-nvim').setup {
      mappings = mappings,
      rememberBuffers = false,
    }
  end,
}
