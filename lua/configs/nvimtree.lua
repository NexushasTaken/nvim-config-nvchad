return {
  auto_reload_on_write = true,
  sort_by = "extension",
  hijack_cursor = false,
  hijack_netrw = true,
  open_on_tab = false,
  reload_on_bufenter = true,
  view = {
    cursorline = false,
    number = true,
    relativenumber = true,
    preserve_window_proportions = true,
  },
  renderer = {
    add_trailing = true,
    group_empty = false,
    highlight_git = true,
    highlight_hidden = "all",
    full_name = true,
    indent_width = 2,
    indent_markers = {
      enable = true,
      icons = {
        corner = "╰",
        bottom = "─",
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  filters = {
    enable = true,
    dotfiles = true,
    git_ignored = true,
    custom = { "__pycache__", "*.uid", "*.import", "*.meta" },
  },
  actions = {
    change_dir = {
      enable = true,
    },
    open_file = {
      quit_on_open = true,
    },
  },
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  git = {
    enable = true,
  },
  on_attach = function(bufnr)
    local api = require("nvim-tree.api")
    local set = vim.keymap.set

    local opts = function(desc)
      return {
        desc = "nvim-tree: " .. desc,
        buffer = bufnr,
        noremap = true,
        silent = true,
        nowait = true,
      }
    end

    set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
    set("n", "<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
    set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
    --set("n", "<C-r>", api.fs.rename_sub,                  opts("Rename: Omit Filename"));
    set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
    set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
    set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
    set("n", "<BS>", api.node.navigate.parent_close, opts("Close Directory"))
    set("n", "<CR>", api.node.open.edit, opts("Open"))
    set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
    set("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
    set("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
    set("n", ".", api.node.run.cmd, opts("Run Command"))
    set("n", "-", api.tree.change_root_to_parent, opts("Up"))
    set("n", "a", api.fs.create, opts("Create"))
    --set("n", "bd",    api.marks.bulk.delete,              opts("Delete Bookmarked"));
    --set("n", "bmv",   api.marks.bulk.move,                opts("Move Bookmarked"));
    set("n", "B", api.filter.no_buffer.toggle, opts("Toggle Filter: No Buffer"))
    set("n", "c", api.fs.copy.node, opts("Copy"))
    set("n", "C", api.filter.git.clean.toggle, opts("Toggle Filter: Git Clean"))
    set("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
    set("n", "]c", api.node.navigate.git.next, opts("Next Git"))
    set("n", "d", api.fs.remove, opts("Delete"))
    set("n", "D", api.fs.trash, opts("Trash"))
    set("n", "E", api.tree.expand_all, opts("Expand All"))
    --set("n", "e",     api.fs.rename_basename,             opts("Rename: Basename"));
    set("n", "]e", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
    set("n", "[e", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
    set("n", "F", api.filter.live.clear, opts("Clean Filter"))
    set("n", "f", api.filter.live.start, opts("Filter"))
    set("n", "g?", api.tree.toggle_help, opts("Help"))
    set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
    set("n", "H", api.filter.dotfiles.toggle, opts("Toggle Filter: Dotfiles"))
    set("n", "I", api.filter.git.ignored.toggle, opts("Toggle Filter: Git Ignore"))
    set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
    set("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
    --set("n", "m",     api.marks.toggle,                   opts("Toggle Bookmark"));
    set("n", "o", api.node.open.edit, opts("Open"))
    set("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
    set("n", "p", api.fs.paste, opts("Paste"))
    set("n", "P", api.node.navigate.parent, opts("Parent Directory"))
    set("n", "q", api.tree.close, opts("Close"))
    set("n", "r", api.fs.rename, opts("Rename"))
    set("n", "R", api.tree.reload, opts("Refresh"))
    set("n", "S", api.tree.search_node, opts("Search"))
    set("n", "U", api.filter.custom.toggle, opts("Toggle Filter: Hidden"))
    set("n", "W", api.tree.collapse_all, opts("Collapse All"))
    set("n", "x", api.fs.cut, opts("Cut"))
    set("n", "y", api.fs.copy.filename, opts("Copy Name"))
    set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
  end,
}
