local function bracketed()
  local api = require("mini.bracketed")
  api.setup()
end

local function sessions()
  local api = require("mini.sessions")
  api.setup({
    force = { read = true, write = true, delete = true },
    verbose = { read = true, write = true, delete = true },
  })
end

local function surround()
  local api = require("mini.surround")
  api.setup()
end

local function splitjoin()
  local api = require("mini.splitjoin")
  api.setup()
end

local function mini_pairs()
  local api = require("mini.pairs")
  api.setup({
    modes = {
      command = false,
      terminal = true,
    },
  })
end

local function comment()
  local api = require("mini.comment")
  api.setup({
    options = {
      ignore_blank_line = true,
    },
  })
end

local function trailspace()
  local api = require("mini.trailspace")
  api.setup()
end

local function indentscope()
  local api = require("mini.indentscope")
  api.setup({
    draw = {
      animation = api.gen_animation.none(),
    },
  })
end

local function statusline()
  local api = require("mini.statusline")
  local function active()
    local mode, mode_hl = MiniStatusline.section_mode({})
    local git = MiniStatusline.section_git({})
    local diff = MiniStatusline.section_diff({})
    local diagnostics = MiniStatusline.section_diagnostics({
      signs = { ERROR = "󰅚 ", WARN = "󰀪 ", INFO = "󰋽 ", HINT = "󰌶 " },
    })
    local lsp = MiniStatusline.section_lsp({})
    local filename = MiniStatusline.section_filename({ trunc_width = 110 })
    local fileinfo = MiniStatusline.section_fileinfo({})
    local location = MiniStatusline.section_location({})
    local search = MiniStatusline.section_searchcount({})

    return MiniStatusline.combine_groups({
      { hl = mode_hl, strings = { mode } },
      { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
      "%<", -- Mark general truncate point
      { hl = "MiniStatuslineFilename", strings = { filename } },
      "%=", -- End left alignment
      { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
      { hl = mode_hl, strings = { search, location } },
    })
  end

  api.setup({
    content = {
      active = active,
      inactive = nil,
    },
    use_icons = true,
  })
end

return function()
  comment()
  mini_pairs()
  splitjoin()
  surround()

  bracketed()
  sessions()

  indentscope()
  -- statusline()
  trailspace()
end
