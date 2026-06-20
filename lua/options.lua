require("nvchad.options")

local o = vim.opt
local g = vim.g

o.wrap = true
o.magic = true
o.number = true
o.undofile = true
o.autoread = true
o.smartcase = true
o.linebreak = true
o.autoindent = true
o.shiftround = true
o.cursorline = true
o.breakindent = true
o.smartindent = false
o.equalalways = true
o.termguicolors = true
o.relativenumber = true
o.backup = false
o.timeout = false
o.showmode = false
o.autochdir = false
o.foldenable = false
o.compatible = false
o.tabstop = 2
o.foldlevel = 0
o.scrolloff = 2
o.shiftwidth = 2
o.sidescroll = 0
o.softtabstop = 2
o.showtabline = 1
o.sidescrolloff = 2
o.fillchars = {
  fold = " ",
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertright = "┣",
  vertleft = "┫",
  verthoriz = "╋",
}
o.mouse = ""
o.belloff = ""
o.showbreak = "󰞔 "
o.clipboard = "unnamed"
o.cursorlineopt = "number"
o.expandtab = vim.bo.filetype ~= "make"
o.cinoptions = "l1N-s,E-s,t0,U1"
o.formatexpr = [[v:lua.require("conform").formatexpr()]]

o.matchpairs:append("<:>")
o.runtimepath:remove("/usr/share/vim/vimfiles") -- separate vim plugins from neovim in case vim still in use
vim.cmd.syntax("clear")

g.python_recommended_style = 0
g.rust_recommended_style = 0
g.meson_recommended_style = 0
g.yaml_recommended_style = 0
g.markdown_recommended_style = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.bracey_refresh_on_save = 1
