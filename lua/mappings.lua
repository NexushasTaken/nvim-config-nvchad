-- require "nvchad.mappings"

local map = vim.keymap.set

map("n", "<leader>q", ":qa!<cr>")
map("n", "<esc>", ":noh<cr>", { desc = "general clear highlights" })
map("n", "<leader>n", ":NvimTreeFocus<cr>", { desc = "nvimtree focus window" })
map("n", "<leader>o", ":Oil<cr>")

map("n", "zZ", function()
  if vim.opt.foldmethod:get() == "manual" then
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    print("fold method: expr")
  elseif vim.opt.foldmethod:get() == "expr" then
    vim.opt.foldmethod = "manual"
    vim.opt.foldexpr = "0"
    print("fold method: manual")
  end
end)

-- tabufline
if require("nvconfig").ui.tabufline.enabled then
  map("n", "<leader>b", ":enew<CR>", { desc = "buffer new" })

  map("n", "<tab>", function()
    require("nvchad.tabufline").next()
  end, { desc = "buffer goto next" })

  map("n", "<S-tab>", function()
    require("nvchad.tabufline").prev()
  end, { desc = "buffer goto prev" })

  map("n", "<leader>x", function()
    require("nvchad.tabufline").close_buffer()
  end, { desc = "buffer close" })
end

map("n", "do", vim.diagnostic.open_float)
map("n", "<leader>lj", function()
  vim.diagnostic.jump({ count = 1 })
end)
map("n", "<leader>lk", function()
  vim.diagnostic.jump({ count = -1 })
end)

do
  local ok, conform = pcall(require, "conform")

  if ok then
    map("n", "<leader>lf", function()
      if not conform.format({ async = true }) then
        vim.lsp.buf.format({ async = true })
      end
    end, { noremap = true, desc = "Format" })
  end
end

map("n", "<leader>m", function()
  local lbuf = vim.bo[vim.api.nvim_get_current_buf()]
  lbuf.modifiable = not lbuf.modifiable
  print(lbuf.modifiable and "ReadWrite" or "Readonly")
end)

local sessionname = vim.fn.sha256(vim.fn.getcwd()) .. ".session"

map("n", "<leader>sD", function()
  MiniSessions.delete(sessionname)
end)

map("n", "<leader>ss", function()
  MiniSessions.write(sessionname)
end)

map("n", "<leader>sl", function()
  local ok, _ = pcall(MiniSessions.read, sessionname)
  if not ok then
    vim.api.nvim_echo({ { "(mini.sessions) ", "WarningMsg" }, { "There is no detected sessions." } }, true, {})
  end
end)

do
  local ok, textcase = pcall(require, "textcase")

  if ok then
    -- TODO: Figure this out why 'w' is appending when testcase keybinds are executed.
    local remove_w = function()
      local keys = vim.api.nvim_replace_termcodes("<BS><ESC>", true, false, true)
      vim.api.nvim_feedkeys(keys, "x", false)
    end

    map("n", "<leader>au", function()
      textcase.current_word("to_upper_case")
      remove_w()
    end, { desc = "TO UPPER CASE" })
    map("n", "<leader>al", function()
      textcase.current_word("to_lower_case")
      remove_w()
    end, { desc = "to lower case" })
    map("n", "<leader>as", function()
      textcase.current_word("to_snake_case")
      remove_w()
    end, { desc = "to_snake_case" })
    map("n", "<leader>ad", function()
      textcase.current_word("to_dash_case")
      remove_w()
    end, { desc = "to.dash.case" })
    map("n", "<leader>an", function()
      textcase.current_word("to_constant_case")
      remove_w()
    end, { desc = "TO_CONSTANT_CASE" })
    map("n", "<leader>ad", function()
      textcase.current_word("to_dot_case")
      remove_w()
    end, { desc = "to.dot.case" })
    map("n", "<leader>a,", function()
      textcase.current_word("to_comma_case")
      remove_w()
    end, { desc = "to,comma,case" })
    map("n", "<leader>aa", function()
      textcase.current_word("to_phrase_case")
      remove_w()
    end, { desc = "To phrase case" })
    map("n", "<leader>ac", function()
      textcase.current_word("to_camel_case")
      remove_w()
    end, { desc = "toCamelCase" })
    map("n", "<leader>ap", function()
      textcase.current_word("to_pascal_case")
      remove_w()
    end, { desc = "ToPascalCase" })
    map("n", "<leader>at", function()
      textcase.current_word("to_title_case")
      remove_w()
    end, { desc = "To Title Case" })
    map("n", "<leader>af", function()
      textcase.current_word("to_path_case")
      remove_w()
    end, { desc = "to/path/case" })

    map("v", "<leader>au", function()
      textcase.current_word("to_upper_case")
      remove_w()
    end, { desc = "TO UPPER CASE" })
    map("v", "<leader>al", function()
      textcase.current_word("to_lower_case")
      remove_w()
    end, { desc = "to lower case" })
    map("v", "<leader>as", function()
      textcase.current_word("to_snake_case")
      remove_w()
    end, { desc = "to_snake_case" })
    map("v", "<leader>ad", function()
      textcase.current_word("to_dash_case")
      remove_w()
    end, { desc = "to.dash.case" })
    map("v", "<leader>an", function()
      textcase.current_word("to_constant_case")
      remove_w()
    end, { desc = "TO_CONSTANT_CASE" })
    map("v", "<leader>ad", function()
      textcase.current_word("to_dot_case")
      remove_w()
    end, { desc = "to.dot.case" })
    map("v", "<leader>a,", function()
      textcase.current_word("to_comma_case")
      remove_w()
    end, { desc = "to,comma,case" })
    map("v", "<leader>aa", function()
      textcase.current_word("to_phrase_case")
      remove_w()
    end, { desc = "To phrase case" })
    map("v", "<leader>ac", function()
      textcase.current_word("to_camel_case")
      remove_w()
    end, { desc = "toCamelCase" })
    map("v", "<leader>ap", function()
      textcase.current_word("to_pascal_case")
      remove_w()
    end, { desc = "ToPascalCase" })
    map("v", "<leader>at", function()
      textcase.current_word("to_title_case")
      remove_w()
    end, { desc = "To Title Case" })
    map("v", "<leader>af", function()
      textcase.current_word("to_path_case")
      remove_w()
    end, { desc = "to/path/case" })

    map("n", "<leader>O", ":AerialOpen<CR>")
  end
end
