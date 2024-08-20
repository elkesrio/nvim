return function(m, k, v, desc)
  vim.keymap.set(m, k, v, { desc = desc })
end
