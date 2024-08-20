local split = require('custom.helpers').split

local fields = split(vim.loop.cwd(), '/')

vim.opt.shadafile = os.getenv 'HOME' .. '/.local/share/nvim/shada/__' .. fields[#fields] .. '__/.shadafile'
