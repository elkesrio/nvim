local function is_whitespace(line)
  return vim.fn.match(line, [[^\s*$]]) ~= -1
end

local function all(tbl, check)
  for _, entry in ipairs(tbl) do
    if not check(entry) then
      return false
    end
  end
  return true
end

return {
  'AckslD/nvim-neoclip.lua',
  event = 'VimEnter',
  requires = {
    { 'kkharji/sqlite.lua', module = 'sqlite' },
    { 'nvim-telescope/telescope.nvim' },
  },
  config = function()
    require('neoclip').setup {
      enable_persistent_history = true,
      enable_macro_history = true,
      keys = {
        telescope = {
          i = {
            select = '<cr>',
            paste = '<c-p>',
            paste_behind = '<c-s-p>',
            replay = '<c-q>', -- replay a macro
            delete = '<c-d>', -- delete an entry
            edit = '<c-e>', -- edit an entry
            custom = {},
          },
          n = {
            select = '<cr>',
            paste = { 'p', '<c-p>' },
            paste_behind = { 'P', '<c-s-p>' },
            replay = 'q',
            delete = 'd',
            edit = 'e',
            custom = {},
          },
        },
      },
    }
  end,
  filter = function(data)
    return not all(data.event.regcontents, is_whitespace)
  end,
}
