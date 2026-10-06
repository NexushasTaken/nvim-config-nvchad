local opt = vim.opt
local fn = vim.fn

local swapfilelist = function()
  local swapfiles = {}
  for _, swapdir in pairs(opt.directory:get()) do
    for _, item in pairs(fn.readdir(swapdir)) do
      table.insert(swapfiles, swapdir .. item)
    end
  end

  return swapfiles
end

-- delete stale swap files of the current buffer, keep the live one
vim.api.nvim_create_user_command("SwapDelete", function()
  local buf_swapfile = fn.swapname(fn.bufname())
  local buf_suffix = string.sub(buf_swapfile, -2)
  local buf_info = fn.swapinfo(buf_swapfile)

  for _, file in pairs(swapfilelist()) do
    local file_suffix = string.sub(file, -2)
    local info = fn.swapinfo(file)
    if info.fname == buf_info.fname and file_suffix ~= buf_suffix then
      fn.delete(file)
      print("deleted:", info.fname .. ".s" .. file_suffix)
    end
  end

  if fn.swapinfo(buf_swapfile) == nil then
    vim.notify(buf_swapfile .. " is deleted", vim.log.levels.ERROR)
  end
end, { nargs = 0 })
