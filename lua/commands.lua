vim.api.nvim_create_user_command("PackAdd", function(opts)
        vim.pack.add(opts.fargs)
end, { nargs = "+", desc = "Add plugins" })

vim.api.nvim_create_user_command("PackDel", function(opts)
        vim.pack.del(opts.fargs)
end, { nargs = "+", desc = "Delete plugins" })

vim.api.nvim_create_user_command("PackUpdate", function(opts)
    if opts.args:match("%S") then
        local plugins = vim.split(opts.args, "%s+", { trimempty = true })
        vim.pack.update(plugins)
    else
        vim.pack.update()
    end
end, { nargs = "*", desc = "Update plugins" })

-- -- Auto-open dashboard when buffers are closed
-- vim.api.nvim_create_autocmd("BufDelete", {
--     callback = function()
--         vim.schedule(function()
--             local is_real_buffer_left = false
--             local bufs = vim.api.nvim_list_bufs()
--             
--             for _, buf in ipairs(bufs) do
--                 if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
--                     local ft = vim.bo[buf].filetype
--                     local name = vim.api.nvim_buf_get_name(buf)
--                     if ft ~= "NvimTree" and ft ~= "starter" and ft ~= "" then
--                         is_real_buffer_left = true
--                         break
--                     end
--                 end
--             end
-- 
--             if not is_real_buffer_left then
--                 local tree_api = require("nvim-tree.api")
--                 if tree_api.tree.is_visible() then
--                     tree_api.tree.close()
--                 end
--                 
--                 -- Close session on exit to dashboard
--                 pcall(function() vim.cmd("SClose") end)
-- 
--                 if vim.bo.filetype ~= "starter" then
--                     require('mini.starter').open()
--                 end
--             end
--         end)
--     end,
-- })
