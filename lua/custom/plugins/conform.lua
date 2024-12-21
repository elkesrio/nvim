return { -- Autoformat
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 5000,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      ruby = function(bufnr)
        local current_dir = vim.loop.cwd()
        local sorare_root_dir = vim.fn.expand '~/dev/sorare/'

        if current_dir:find(sorare_root_dir, 1, true) then
          return { 'prettierd' }
        else
          return { 'rubocop' }
        end
      end,
    },
  },
}
