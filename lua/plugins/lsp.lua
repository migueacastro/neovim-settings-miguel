require("mason").setup()

-- Default servers
local servers = {
  "svelte-language-server",
  "pyright",
  "lua_ls",
  "marksman",
  "gopls",
  "rust_analyzer",
}

local mapping = {
  lua_ls = "lua-language-server",
  rust_analyzer = "rust-analyzer",
}

local mr = require("mason-registry")

mr.refresh(function()
  for _, name in ipairs(servers) do
    local mason_name = mapping[name] or name
    if mr.has_package(mason_name) then
      local p = mr.get_package(mason_name)
      if not p:is_installed() then
        print("Installing: " .. mason_name)
        p:install()
      end
    end
  end
end)

vim.lsp.enable(servers)

-- Keymaps
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Definition" })
vim.keymap.set("n", "fm", vim.lsp.buf.format, { desc = "Format" })
vim.keymap.set("n", "df", vim.diagnostic.open_float, { desc = "Diagnostics" })

vim.diagnostic.config({
    virtual_text = true,
    update_in_insert = true,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = vim.tbl_deep_extend("force", capabilities, require("mini.completion").get_lsp_capabilities())

vim.lsp.config("*", { capabilities = capabilities })
-- Server overrides
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
    },
  },
})

-- Management commands
vim.api.nvim_create_user_command("LspInstall", function(opts)
  local server = opts.args
  if server == "" then return end

  local mason_name = mapping[server] or server

  if not mr.has_package(mason_name) then
    print("Error: '" .. server .. "' not found in registry.")
    return
  end

  vim.cmd("MasonInstall " .. mason_name)
  vim.lsp.enable(server)

  local file_path = vim.fn.stdpath("config") .. "/lua/plugins/lsp.lua"
  local lines = vim.fn.readfile(file_path)
  local new_lines = {}
  local found_table = false
  local already_exists = false

  for _, line in ipairs(lines) do
    if line:match('"' .. server .. '"') then already_exists = true end
  end

  if not already_exists then
    for _, line in ipairs(lines) do
      table.insert(new_lines, line)
      if not found_table and line:match("local servers = {") then
        table.insert(new_lines, '\t"' .. server .. '",')
        found_table = true
      end
    end
    vim.fn.writefile(new_lines, file_path)
    print("Installed and added to config.")
  end
end, {
  nargs = 1,
  complete = function(ArgLead)
    local all = mr.get_all_package_names()
    return vim.tbl_filter(function(name)
      return name:find(ArgLead, 1, true)
    end, all)
  end
})

vim.api.nvim_create_user_command("LspUninstall", function(opts)
  local server = opts.args
  if server == "" then return end

  local file_path = vim.fn.stdpath("config") .. "/lua/plugins/lsp.lua"
  local lines = vim.fn.readfile(file_path)
  local new_lines = {}
  local removed = false

  for _, line in ipairs(lines) do
    if line:match('"' .. server .. '"') then
      removed = true
    else
      table.insert(new_lines, line)
    end
  end

  if removed then
    vim.fn.writefile(new_lines, file_path)
    local mason_name = mapping[server] or server
    if mr.has_package(mason_name) then
      vim.cmd("MasonUninstall " .. mason_name)
    end
    print("Removed from config and uninstalled.")
  end
end, {
  nargs = 1,
  complete = function(ArgLead)
    local installed = mr.get_installed_package_names()
    return vim.tbl_filter(function(name)
      return name:find(ArgLead, 1, true)
    end, installed)
  end
})
