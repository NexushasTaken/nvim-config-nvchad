local data_path = vim.fn.stdpath("data")
local meson_path = data_path .. "/mason/bin"
vim.env.PATH = vim.env.PATH .. ":" .. meson_path

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "yapf", "black", "isort" },
    rust = { "rustfmt" },
    javascript = { "prettierd", "prettier" },
    typst = { "prettypst", "typstyle" },
    c = "clang-format",
    cpp = "clang-format",
  },
  default_format_opts = {
    lsp_format = "fallback",
    stop_after_first = true,
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
