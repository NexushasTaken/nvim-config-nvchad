return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    -- config = require("configs.treesitter"),
    dependencies = {
      { -- Auto close tag
        "windwp/nvim-ts-autotag",
        opts = {
          opts = {
            enable_close = true, -- Auto close tags
            enable_rename = true, -- Auto rename pairs of tags
            enable_close_on_slash = true, -- Auto close on trailing </
          },
        },
        ft = {
          "html",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "svelte",
          "vue",
          "tsx",
          "jsx",
          "rescript",
          "xml",
          "php",
          "markdown",
          "glimmer",
          "handlebars",
          "hbs",
        },
      },
    },
  },
}
