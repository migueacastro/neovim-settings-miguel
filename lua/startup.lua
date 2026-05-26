local function setup_startup(data)
  local is_real_file = vim.fn.filereadable(data.file) == 1
  
  if is_real_file then
    -- Open tree on file entry
    require("nvim-tree.api").tree.open()
    vim.cmd("wincmd l")
  else
    -- Close tree to center dashboard
    require("nvim-tree.api").tree.close()
  end
end

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = setup_startup,
})

vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        vim.schedule(function()
            local ft = vim.bo.filetype
            local bt = vim.bo.buftype
            if bt == "" and ft ~= "" and ft ~= "NvimTree" and ft ~= "starter" then
                local tree_api = require("nvim-tree.api")
                if not tree_api.tree.is_visible() then
                    tree_api.tree.open()
                    vim.cmd("wincmd l")
                end
            end
        end)
    end
})
