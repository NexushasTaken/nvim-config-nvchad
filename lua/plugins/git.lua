-- git plugins, all disabled for now
return {
  { -- Neogit
    "NeogitOrg/neogit",
    enabled = false,
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {},
  },

  { -- Diffview
    "sindrets/diffview.nvim",
    enabled = false,
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    opts = {},
  },

  { -- Vim fugitive
    "tpope/vim-fugitive",
    enabled = false,
    cmd = { "Git", "G" },
  },
}
