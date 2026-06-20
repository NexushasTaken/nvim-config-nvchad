---@module "lazy"
---@type LazyPluginSpec[]
return {
  {
    "kristijanhusak/vim-dadbod-ui",
    event = "InsertEnter",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },

  {
    "saghen/blink.cmp",
    version = "v1.4.*",
    event = "InsertEnter",
    dependencies = {
      {
        "disrupted/blink-cmp-conventional-commits",
        {
          "Kaiser-Yang/blink-cmp-dictionary",
          dependencies = { "nvim-lua/plenary.nvim" },
        },
        { "bydlw98/blink-cmp-env", keys = "$" },
        { "Kaiser-Yang/blink-cmp-git", keys = { "#", "!", ":", "@" } },
        { "MahanRahmati/blink-nerdfont.nvim", keys = { ":" } },
        { "onsails/lspkind.nvim", opts = { preset = "default" } },
        {
          -- snippet plugin
          "L3MON4D3/LuaSnip",
          -- dependencies = "rafamadriz/friendly-snippets",
          opts = { history = true, updateevents = "TextChanged,TextChangedI" },
          config = function(_, opts)
            require("luasnip").config.set_config(opts)
            require("nvchad.configs.luasnip")
          end,
        },
        config = function()
          local lazy_load = function(snip)
            require("luasnip/loaders/from_vscode").lazy_load({
              paths = { vim.fn.stdpath("config") .. "/snippets/" .. snip },
            })
          end

          lazy_load("friendly-snippets")
          lazy_load("odoo-snippets")
        end,
      },
      -- "rafamadriz/friendly-snippets",
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    opts_extend = { "sources.default" },
    opts = function()
      return require("configs.blink-cmp")
    end,
  },
}
