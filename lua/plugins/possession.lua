require('possession').setup {
    session_dir = vim.fn.stdpath('data') .. '/possession',
    silent = false,
    load_silent = true,
    autosave = {
        current = true,
        on_load = true,
        on_quit = true,
    },
    commands = {
        save = 'SSave',
        load = 'SLoad',
        rename = 'SRename',
        close = 'SClose',
        delete = 'SDelete',
        show = 'SShow',
        list = 'SList',
        migrate = 'SMigrate',
    },
    plugins = {
        close_windows = {
            hooks = {'before_save', 'before_load'},
            preserve_layout = true,
            match = { floating = true },
        },
        delete_buffers = false,
        delete_hidden_buffers = false,
        nvim_tree = true,
        tabby = true,
    },
}

-- Ensure sessionoptions handles buffers correctly
vim.opt.sessionoptions:append('globals')
vim.opt.sessionoptions:remove('options')

vim.keymap.set('n', '<leader>ss', '<cmd>SSave<cr>', { desc = 'Save session' })
vim.keymap.set('n', '<leader>sl', '<cmd>SList<cr>', { desc = 'List sessions' })
