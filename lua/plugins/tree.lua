local config = {
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  actions = {
    open_file = {
      quit_on_open = false,
      window_picker = {
        enable = true,
      },
    },
  },
}
require("nvim-tree").setup(config)

vim.keymap.set("n", "<C-e>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle Nvim Tree", silent = true })
