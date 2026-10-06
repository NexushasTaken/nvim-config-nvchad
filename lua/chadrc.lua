-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "tokyonight",

  -- groups that base46 already defines
  hl_override = {
    Todo = { fg = "yellow", bg = "black" },
    Folded = { fg = "grey_fg", bg = "NONE" },
  },

  -- groups that base46 does not define
  hl_add = {
    RenderMarkdownCodeInline = { fg = "blue", bg = "one_bg" },
    ["@markup.raw.markdown_inline"] = { fg = "blue", bg = "one_bg" },
    DiagnosticUnderlineError = { underline = true, undercurl = false, sp = "red" },
    DiagnosticUnderlineWarn = { underline = true, undercurl = false, sp = "red" },
    DiagnosticUnderlineInfo = { underline = true, undercurl = false, sp = "red" },
    DiagnosticUnderlineHint = { underline = true, undercurl = false, sp = "red" },
  },
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--   tabufline = {
--     lazyload = false,
--   },
-- }

return M
