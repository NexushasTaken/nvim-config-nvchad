dofile(vim.g.base46_cache .. "blink")

local sources = {
  dictionary = false,
}

-- Use this function to check if the cursor is inside a comment block
local function inside_comment_block()
  if vim.api.nvim_get_mode().mode ~= "i" then
    return false
  end
  local node_under_cursor = vim.treesitter.get_node()
  local parser = vim.treesitter.get_parser(nil, nil, { error = false })
  if not parser then
    return false
  end
  local query = vim.treesitter.query.get(vim.bo.filetype, "highlights")
  if not node_under_cursor or not query then
    return false
  end
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1
  for id, node, _ in query:iter_captures(node_under_cursor, 0, row, row + 1) do
    if query.captures[id]:find("comment") then
      local start_row, start_col, end_row, end_col = node:range()
      if start_row <= row and row <= end_row then
        if start_row == row and end_row == row then
          if start_col <= col and col <= end_col then
            return true
          end
        elseif start_row == row then
          if start_col <= col then
            return true
          end
        elseif end_row == row then
          if col <= end_col then
            return true
          end
        else
          return true
        end
      end
    end
  end
  return false
end

---@module "blink.cmp"
---@type blink.cmp.Config
return {
  completion = {
    keyword = { range = "full" },
    ghost_text = { enabled = false },
    trigger = {
      show_on_keyword = false,
      show_on_trigger_character = false,
    },
    list = {
      selection = {
        preselect = true,
        auto_insert = false,
      },
    },
    menu = {
      auto_show = false,
      draw = {
        treesitter = { "lsp" },
        columns = { { "kind_icon" }, { "label", "label_description", "source_name", gap = 1 } },
      },
    },
  },

  appearance = {
    highlight_ns = vim.api.nvim_create_namespace("blink_cmp"),
    -- Sets the fallback highlight groups to nvim-cmp"s highlight groups
    -- Useful for when your theme doesn"t support blink.cmp
    -- Will be removed in a future release
    use_nvim_cmp_as_default = false,
    -- Set to "mono" for "Nerd Font Mono" or "normal" for "Nerd Font"
    -- Adjusts spacing to ensure icons are aligned
    nerd_font_variant = "mono",
  },

  signature = {
    enabled = true,
    trigger = {
      show_on_insert = true,
      show_on_accept = true,
    },
  },

  keymap = {
    preset = "default",
    ["<Esc>"] = {
      function(cmp)
        if cmp.is_visible() then
          cmp.hide()
        end
        local luasnip = require("luasnip")
        if luasnip.in_snippet() then
          luasnip.unlink_current()
        end
        return false
      end,
      "fallback",
    },
    ["<C-e>"] = { "show", "hide" },
    ["<C-space>"] = { "show_documentation", "hide_documentation" },
    ["<Enter>"] = {
      "select_and_accept",
      "fallback",
    },

    ["<Tab>"] = {
      function(cmp)
        if cmp.is_visible() then
          cmp.select_next()
          return true
        end
      end,
      "snippet_forward",
      "fallback",
    },
    ["<S-Tab>"] = {
      function(cmp)
        if cmp.is_visible() then
          cmp.select_prev()
          return true
        end
      end,
      "snippet_backward",
      "fallback",
    },
    ["<C-q>"] = {
      "show_signature",
      "hide_signature",
      "fallback",
    },
    ["<C-p>"] = {
      function(cmp)
        cmp.scroll_documentation_up(1)
      end,
    },
    ["<C-n>"] = {
      function(cmp)
        cmp.scroll_documentation_down(1)
      end,
    },
  },

  snippets = {
    preset = "luasnip",
  },

  sources = {
    default = function()
      -- put those which will be shown always
      local result = {
        "lazydev",
        "lsp",
        "path",
        "snippets",
        "buffer",
        "nerdfont",
        "git",
        "env",
        "conventional_commits",
      }
      if -- ref: https://github.com/Kaiser-Yang/blink-cmp-dictionary?tab=readme-ov-file#how-to-enable-this-plugin-for-comment-blocks-or-specific-file-types-only
        -- turn on dictionary in markdown or text file
        (
          vim.tbl_contains({ "markdown", "text" }, vim.bo.filetype)
          -- or turn on dictionary if cursor is in the comment block
          or inside_comment_block()
        ) and sources.dictionary
      then
        table.insert(result, "dictionary")
      end
      return result
    end,

    per_filetype = {
      sql = { "snippets", "dadbod", "buffer" },
    },

    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
      },
      nerdfont = {
        enabled = false,
        module = "blink-nerdfont",
        name = "Nerd Fonts",
        score_offset = 15, -- Tune by preference
        opts = { insert = true }, -- Insert nerdfont icon (default) or complete its name
      },
      git = {
        module = "blink-cmp-git",
        name = "Git",
      },
      env = {
        enabled = false,
        name = "Env",
        module = "blink-cmp-env",
        ---@module "blink-cmp-env"
        ---@type blink-cmp-env.Options
        opts = {
          show_braces = false,
          show_documentation_window = true,
        },
      },
      ---@module "blink-cmp-dictionary"
      ---@type blink-cmp-dictionary.Options
      dictionary = {
        module = "blink-cmp-dictionary",
        name = "Dict",
        min_keyword_length = 3,
        opts = {
          dictionary_files = { "/usr/share/wordnet/dict" },
          dictionary_directories = { vim.fn.stdpath("config") .. "/dictionary/" },
        },
      },
      conventional_commits = {
        name = "Conventional Commits",
        module = "blink-cmp-conventional-commits",
        enabled = function()
          return vim.bo.filetype == "gitcommit"
        end,
        ---@module "blink-cmp-conventional-commits"
        ---@type blink-cmp-conventional-commits.Options
        opts = {}, -- none so far
      },
      dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
      cmdline = {
        -- ignores cmdline completions when executing shell commands
        enabled = function()
          return vim.fn.has("win32") == 0
            or vim.fn.getcmdtype() ~= ":"
            or not vim.fn.getcmdline():match("^[%%0-9,'<>%-]*!")
        end,
      },
      buffer = {
        -- keep case of first char
        transform_items = function(a, items)
          local keyword = a.get_keyword()
          local correct, case
          if keyword:match("^%l") then
            correct = "^%u%l+$"
            case = string.lower
          elseif keyword:match("^%u") then
            correct = "^%l+$"
            case = string.upper
          else
            return items
          end

          -- avoid duplicates from the corrections
          local seen = {}
          local out = {}
          for _, item in ipairs(items) do
            local raw = item.insertText
            if raw and raw:match(correct) then
              local text = case(raw:sub(1, 1)) .. raw:sub(2)
              item.insertText = text
              item.label = text
            end
            if not seen[item.insertText] then
              seen[item.insertText] = true
              table.insert(out, item)
            end
          end
          return out
        end,
      },
    },
  },
  fuzzy = {
    sorts = {
      "exact",
      -- defaults
      "score",
      "kind",
      "sort_text",
      ---@param a blink.cmp.CompletionItem
      ---@param b blink.cmp.CompletionItem
      function(a, b)
        local variable_kind_id = require("blink.cmp.types").CompletionItemKind.Variable
        if a.kind == variable_kind_id and b.kind == variable_kind_id then
          return a.source_id == "env"
        end
      end,
    },
  },
}
