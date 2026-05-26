-- Mini.Files
local MiniFiles = require("mini.files")
MiniFiles.setup({
        mappings = {
                go_in = "<CR>",
                go_in_plus = "L",
                go_out = "_",
                go_out_plus = "H",
        },
})

vim.keymap.set("n", "-", "<cmd>lua MiniFiles.open()<CR>", { desc = "File explorer" })
vim.keymap.set("n", "<leader>-", function()
        MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
        MiniFiles.reveal_cwd()
end, { desc = "Locate file" })

-- Mini.Notify
require("mini.notify").setup({
        content = { format = function(notif) return notif.msg end },
})

-- Mini.Cmdline
require("mini.cmdline").setup({ autocorrect = { enable = false } })

-- Essentials
require("mini.surround").setup()
require("mini.bufremove").setup()
require("mini.pairs").setup()
require("mini.comment").setup()

-- Mini.Pick
local MiniPick = require("mini.pick")
local MiniExtra = require("mini.extra")
MiniPick.setup()
MiniExtra.setup()

vim.keymap.set("n", "<leader>pf", function() MiniPick.builtin.files() end, { desc = "Files" })
vim.keymap.set("n", "<leader>ps", function() MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") }) end, { desc = "Grep" })
vim.keymap.set("n", "<leader>ph", function() MiniPick.builtin.help() end, { desc = "Help" })
vim.keymap.set("n", "<leader>xx", function() MiniExtra.pickers.diagnostic() end, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>pk", function() MiniExtra.pickers.keymaps() end, { desc = 'Keymaps' })
vim.keymap.set("n", "<leader>pt", function() 
    MiniExtra.pickers.colorschemes({
        source = {
            choose = function(item)
                vim.cmd.colorscheme(item)
                local file_path = vim.fn.stdpath("config") .. "/lua/plugins/theme.lua"
                vim.fn.writefile({ 'vim.cmd.colorscheme("' .. item .. '")' }, file_path)
                print("Default theme: " .. item)
            end
        }
    }) 
end, { desc = 'Themes' })

-- Mini.Completion
require("mini.completion").setup({ lsp_completion = { auto_setup = true } })

-- Mini.Snippets
local MiniSnippets = require("mini.snippets")
MiniSnippets.setup({
        snippets = { MiniSnippets.gen_loader.from_lang() },
        mappings = {
                expand = '<C-j>',
                jump_next = '<C-j>',
                jump_prev = '<C-k>',
        },
})
MiniSnippets.start_lsp_server({ match = false })

-- Mini.Clue
local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },
    { mode = 'i', keys = '<C-x>' },
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },
    { mode = 'n', keys = '<C-w>' },
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
  },
  clues = {
    { mode = 'n', keys = '<Leader>g', desc = '+Git' },
    { mode = 'n', keys = '<Leader>p', desc = '+Pick' },
    { mode = 'n', keys = '<Leader>v', desc = '+View' },
    { mode = 'n', keys = '<Leader>x', desc = '+Diagnostics' },
    { mode = 'n', keys = '<Leader>s', desc = '+Sessions' },
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
  window = { delay = 300, config = { width = 'auto', border = 'rounded' } },
})

-- Mini.Diff
require("mini.diff").setup({ source = require("mini.diff").gen_source.git({ index = false }) })

-- Mini.Starter
local starter = require('mini.starter')
local function possession_sessions()
    local sessions = require('possession.session').list()
    local items = {}
    for _, data in pairs(sessions) do
        table.insert(items, {
            name = 'Session: ' .. data.name,
            action = 'SLoad ' .. data.name,
            section = 'Sessions',
        })
    end
    return items
end

starter.setup({
        evaluate_single = true,
        header = [[
  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
        ]],
        items = {
                starter.sections.recent_files(5, false),
                possession_sessions,
                starter.sections.builtin_actions(),
        },
        content_hooks = {
                starter.gen_hook.adding_bullet(" "),
                starter.gen_hook.aligning('center', 'center'),
        },
        footer = os.date("󱑒 %A, %B %d"),
})
