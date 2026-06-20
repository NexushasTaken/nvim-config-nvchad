local nvconfig = require("nvchad.configs.lspconfig")
local map = vim.keymap.set

nvconfig.on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))

  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts("List workspace folders"))

  map("n", "K", vim.lsp.buf.hover, opts("Hover"))
  map("n", "gD", vim.lsp.buf.definition, opts("Go to definition"))
  map("n", "gd", vim.lsp.buf.declaration, opts("Go to declaration"))
  map("n", "gr", vim.lsp.buf.references, opts("References"))
  map("n", "<leader>li", vim.lsp.buf.implementation, opts("Go to implementation"))
  map("n", "<leader>la", vim.lsp.buf.code_action, opts("Open code actions"))
  -- map("n", "<leader>lr", vim.lsp.buf.rename, opts "");
  map("n", "<leader>lr", require("nvchad.lsp.renamer"), opts("NvRenamer"))
  map("n", "<leader>ls", vim.lsp.buf.signature_help, opts("Signature help"))
  map("n", "<leader>lq", vim.diagnostic.setloclist, opts("setloclist"))
  map("n", "<leader>lh", vim.lsp.buf.document_highlight, opts("Document highlight"))
  map("n", "<leader>lt", vim.lsp.buf.type_definition, opts("Go to type definition"))

  -- vim.api.nvim_create_autocmd({"CursorMoved"}, {
  --   buffer = bufnr,
  --   command = "lua vim.lsp.buf.clear_references()",
  -- })

  -- local function toSnakeCase(str)
  --   return string.gsub(str, "%s*[- ]%s*", "_")
  -- end

  -- https://github.com/OmniSharp/omnisharp-roslyn/issues/2483
  -- if client.name == "omnisharp" then
  --   local tokenModifiers = client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
  --   for i, v in ipairs(tokenModifiers) do
  --     tokenModifiers[i] = toSnakeCase(v)
  --   end
  --   local tokenTypes = client.server_capabilities.semanticTokensProvider.legend.tokenTypes
  --   for i, v in ipairs(tokenTypes) do
  --     tokenTypes[i] = toSnakeCase(v)
  --   end
  -- end
end

nvconfig.defaults()

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
  virtual_text = false,
  signs = {
    active = signs,
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = "none",
    border = "none",
    source = "none",
    header = "",
    prefix = "",
  },
}

vim.diagnostic.config(config)

local servers = {
  neocmake = {},
  csharp_ls = {},
  clangd = {},
}

for name, opts in pairs(servers) do
  local server_opts = require("lspconfigs." .. name)
  opts = vim.tbl_deep_extend("force", server_opts, opts)
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end

-- read :h vim.lsp.config for changing options of lsp servers
