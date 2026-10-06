local hop_keys = {
  { "w", "HopWord" },
  { "p", "HopPattern" },
  { "l", "HopLine" },
  { "s", "HopLineStart" },
  { "v", "HopVertical" },
  { "a", "HopAnywhere" },
  { "cj", "HopChar1" },
  { "ck", "HopChar2" },
}

return {
  { -- Hop (maintained fork; phaazon/hop.nvim was removed from GitHub)
    "smoka7/hop.nvim",
    opts = {},
    keys = vim.tbl_map(function(key)
      return { "<leader>h" .. key[1], "<cmd>" .. key[2] .. "<cr>", desc = key[2] }
    end, hop_keys),
  },

  { -- Aerial
    "stevearc/aerial.nvim",
    cmd = { "AerialOpen", "AerialToggle", "AerialNavToggle" },
    opts = { show_guides = true },
  },

  { -- Oil
    "stevearc/oil.nvim",
    cmd = { "Oil" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      columns = { "permissions", "size", "icon" },
    },
  },

  { -- Undo tree
    "mbbill/undotree",
    cmd = { "UndotreeToggle" },
    keys = { { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "undotree toggle" } },
    init = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_ShortIndicators = 1
      vim.g.undotree_DiffAutoOpen = 1
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_HelpLine = 0
    end,
  },

  { -- Todo comments
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      return require("configs.todo-comments")
    end,
  },

  { -- Relative numbers disabler
    "nkakouros-original/numbers.nvim",
    keys = { "i" },
    opts = {
      excluded_filetypes = {
        "man",
        "unite",
        "tagbar",
        "startify",
        "gundo",
        "vimshell",
        "w3m",
        "nerdtree",
        "Mundo",
        "MundoDiff",
      },
    },
  },

  { -- Make dirs when saving files
    "jghauser/mkdir.nvim",
    lazy = false,
  },

  { -- Fix tab formats
    "godlygeek/tabular",
    cmd = { "Tabularize" },
  },

  { -- Rainbow CSV
    "mechatroner/rainbow_csv",
    ft = {
      "csv",
      "tsv",
      "csv_semicolon",
      "csv_whitespace",
      "csv_pipe",
      "rfc_csv",
      "rfc_semicolon",
    },
  },

  { -- GNU Info reader
    "HiPhish/info.vim",
    lazy = false,
  },

  { -- Better language support (likely redundant with treesitter)
    "sheerun/vim-polyglot",
    enabled = false,
  },
}
