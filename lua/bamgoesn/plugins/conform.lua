return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>fm',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = '[F]or[M]at buffer',
    },
  },
  opts = {
    notify_on_error = true,
    -- format_on_save = function(bufnr)
    --   local disable_filetypes = { c = true, cpp = true }
    --   return {
    --     timeout_ms = 500,
    --     lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
    --   }
    -- end,
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'ruff_format' },
      rust = { 'rustfmt' },
      cpp = { 'clangd' },
      -- python = { "isort", "black" },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettierd", "prettier", stop_after_first = true },
    },
  },
}
