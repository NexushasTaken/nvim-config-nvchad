-- plugins that are off in nvim-custom, kept here disabled for easy re-enabling
return {
  { -- Copilot
    "github/copilot.vim",
    enabled = false,
    cmd = "Copilot",
  },

  { -- Hard Time
    "m4xshen/hardtime.nvim",
    enabled = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
    },
    opts = {},
  },

  { -- Highlight pairs
    "andymass/vim-matchup",
    enabled = false,
    event = "BufReadPost",
    init = function()
      local html_conf = {
        tagnameonly = 1,
        nolists = 1,
      }
      vim.g.matchup_matchpref = {
        html = html_conf,
        xml = html_conf,
      }
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_offscreen = {}
      vim.g.matchup_matchparen_nomode = "i"
      vim.g.matchup_matchparen_pumvisible = 0
    end,
  },

  { -- Render markdown
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
    ft = "markdown",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.nvim",
    },
    opts = {
      enabled = false,
      completions = {
        lsp = { enabled = true },
      },
    },
  },

  { -- Symbols outline (archived upstream, superseded by aerial)
    "simrat39/symbols-outline.nvim",
    enabled = false,
    cmd = "SymbolsOutline",
    opts = {},
  },

  { -- LSP signature
    "ray-x/lsp_signature.nvim",
    enabled = false,
    event = "LspAttach",
    opts = {
      hint_enable = false,
      handler_opts = {
        border = "none",
      },
    },
  },

  { -- Lint
    "mfussenegger/nvim-lint",
    enabled = false,
    event = "BufWritePost",
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        cpp = { "cpplint" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
