-- only the options that differ from the todo-comments.nvim defaults
return {
  gui_style = {
    fg = "NONE",
    bg = "NONE",
  },
  highlight = {
    multiline = true,
    multiline_pattern = [[^.*: ]],
    keyword = "fg",
    after = "fg",
    pattern = [[\s+(KEYWORDS): ]],
    comments_only = true,
  },
}
