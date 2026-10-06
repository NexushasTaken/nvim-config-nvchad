-- language specific plugins, all disabled until needed
return {
  { -- Lean
    "Julian/lean.nvim",
    enabled = false,
    event = { "BufReadPre *.lean", "BufNewFile *.lean" },
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
    },
    opts = {
      lsp = {},
      mappings = true,
    },
  },

  { -- Flutter
    "nvim-flutter/flutter-tools.nvim",
    enabled = false,
    ft = "dart",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = true,
  },

  { -- Arduino
    "stevearc/vim-arduino",
    enabled = false,
    ft = "arduino",
  },

  { -- Defold
    "monkoose/DoNe",
    enabled = false,
    cmd = "DoNe",
    config = function()
      vim.keymap.set("n", "<F5>", "<Cmd>DoNe build<CR>")
    end,
  },

  { -- Bracey
    "turbio/bracey.vim",
    enabled = false,
    ft = require("configs.web").extensions,
  },

  { -- Emmet
    "mattn/emmet-vim",
    enabled = false,
    ft = require("configs.web").extensions,
  },

  { -- Orgmode TODO: use https://github.com/nvim-neorg/neorg
    "nvim-orgmode/orgmode",
    enabled = false,
    ft = "org",
    opts = {
      org_agenda_files = "~/orgfiles/**/*",
      org_default_notes_file = "~/orgfiles/refile.org",
    },
  },

  { -- Typst preview
    "chomosuke/typst-preview.nvim",
    enabled = false,
    ft = "typst",
    opts = {},
  },

  { -- Markdown preview
    "iamcco/markdown-preview.nvim",
    enabled = false,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = "markdown",
  },

  { -- Markdown editing helpers
    "yousefhadder/markdown-plus.nvim",
    enabled = false,
    ft = "markdown",
    opts = {},
  },
}
