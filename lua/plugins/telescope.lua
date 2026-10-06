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

      map("n", "<leader>dc", function()
        builtin.buffers(themes.get_ivy({
          previewer = true,
          show_all_buffers = true,
          sort_lastused = true,
          shorten_path = true,
          attach_mappings = function(prompt_bufnr, attach_map)
            local action_state = require("telescope.actions.state")
            attach_map("i", "<C-d>", function()
              action_state.get_current_picker(prompt_bufnr):delete_selection(function(selection)
                vim.api.nvim_buf_delete(selection.bufnr, { force = true })
              end)
            end)
            return true
          end,
        }))
      end, { noremap = true, desc = "telescope buffers (delete with <C-d>)" })

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

      pcall(scope.load_extension, "fzf")
    end,
    dependencies = {
      "nvim-lua/plenary.nvim", -- Some tools for Lua?
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
  },
}
