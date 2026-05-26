local treesitter = require("nvim-treesitter")

-- Default parsers
local parsers = {
	"go",
	"rust",
	"typescript",
	"javascript",
	"tsx",
	"html",
	"css",
	"json",
	"bash",
	"http",
	"dockerfile",
	"svelte",
	"python",
	"lua",
}

treesitter.install(parsers)

-- Auto-enable treesitter for all files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function(args)
		local buf = args.buf
		local ft = vim.bo[buf].filetype
		local lang = vim.treesitter.language.get_lang(ft)
		if not lang then return end
		if not pcall(vim.treesitter.language.add, lang) then return end
		pcall(vim.treesitter.start, buf, lang)
	end,
})

-- Management commands
vim.api.nvim_create_user_command("TSInstallPersist", function(opts)
    local lang = opts.args
    if lang == "" then return end

    local available = require('nvim-treesitter.parsers')
    if not available[lang] then
        print("Error: '" .. lang .. "' not found.")
        return
    end

    vim.cmd("TSInstall " .. lang)

    local file_path = vim.fn.stdpath("config") .. "/lua/plugins/treesitter.lua"
    local lines = vim.fn.readfile(file_path)
    local new_lines = {}
    local found_table = false
    local already_exists = false

    for _, line in ipairs(lines) do
        if line:match('"' .. lang .. '"') then already_exists = true end
    end

    if not already_exists then
        for _, line in ipairs(lines) do
            table.insert(new_lines, line)
            if not found_table and line:match("local parsers = {") then
                table.insert(new_lines, '\t"' .. lang .. '",')
                found_table = true
            end
        end
        vim.fn.writefile(new_lines, file_path)
        print("Installed and added to config.")
    end
end, { 
    nargs = 1, 
    complete = function(ArgLead)
        local all = vim.tbl_keys(require('nvim-treesitter.parsers'))
        return vim.tbl_filter(function(name)
            return name:find(ArgLead, 1, true)
        end, all)
    end
})

vim.api.nvim_create_user_command("TSUninstallPersist", function(opts)
    local lang = opts.args
    if lang == "" then return end

    local file_path = vim.fn.stdpath("config") .. "/lua/plugins/treesitter.lua"
    local lines = vim.fn.readfile(file_path)
    local new_lines = {}
    local removed = false

    for _, line in ipairs(lines) do
        if line:match('"' .. lang .. '"') then
            removed = true
        else
            table.insert(new_lines, line)
        end
    end

    if removed then
        vim.fn.writefile(new_lines, file_path)
        vim.cmd("TSUninstall " .. lang)
        print("Removed from config and uninstalled.")
    end
end, { 
    nargs = 1, 
    complete = function(ArgLead)
        return vim.tbl_filter(function(name)
            return name:find(ArgLead, 1, true)
        end, parsers)
    end
})
