return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    config = function()
      local map = vim.keymap.set
      local scope = require("telescope")
      local themes = require("telescope.themes")
      local builtin = require("telescope.builtin")
      local theme = "ivy2"

      function themes.get_ivy2(opts)
        opts = opts or {}

        local theme_opts = {
          theme = "ivy",

          sorting_strategy = "ascending",

          layout_strategy = "bottom_pane",
          layout_config = {
            height = function(_, _, max_lines)
              local max = 15
              local lines = math.max(math.floor(max_lines / 2), max)
              if lines < max then
                return max_lines
              else
                return lines
              end
            end,
          },

          border = true,
          borderchars = {
            prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
            results = { " " },
            preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          },
        }
        if opts.layout_config and opts.layout_config.prompt_position == "bottom" then
          theme_opts.borderchars = {
            prompt = { " ", " ", "─", " ", " ", " ", "─", "─" },
            results = { "─", " ", " ", " ", "─", "─", " ", " " },
            preview = { "─", " ", "─", "│", "┬", "─", "─", "╰" },
          }
        end

        return vim.tbl_deep_extend("force", theme_opts, opts)
      end

      map("n", "<leader>ff", function()
        builtin.find_files()
      end, { noremap = true })
      map("n", "<leader>fF", function()
        builtin.find_files({
          find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
        })
      end, { noremap = true })

      map("n", "<leader>fg", function()
        builtin.live_grep({
          glob_pattern = { "!.git/*" },
          additional_args = function()
            return { "--hidden" }
          end,
        })
      end, { noremap = true })

      map("n", "<leader>fh", function()
        builtin.help_tags()
      end, { noremap = true })

      map("n", "<leader>fb", function()
        builtin.buffers()
      end, { noremap = true })

      map("n", "<leader>ft", function()
        builtin.tags()
      end, { noremap = true })

      scope.setup({
        pickers = {
          find_files = { theme = "ivy2" },
          live_grep = { theme = "ivy2" },
          help_tags = { theme = "ivy2" },
          buffers = { theme = "ivy2" },
          tags = { theme = "ivy2" },
        },
        defaults = {
          layout_strategy = "vertical",
        },
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim", -- Some tools for Lua?
    },
  },
}
