local keymap = vim.keymap.set

-- Window manipulation
keymap("n", "<leader>c", "<C-w>c", { desc = "Close the current window" })
keymap("n", "<leader>n", "<C-w>n", { desc = "Create a new window" })

-- Tab management
keymap("n", "<leader>to", vim.cmd.tabnew, { desc = "Open a new tab" })
keymap("n", "<leader>tq", vim.cmd.tabclose, { desc = "Close the current tab" })
keymap("n", "<leader>tn", vim.cmd.tabnext, { desc = "Next tab" })
keymap("n", "<leader>tp", vim.cmd.tabprevious, { desc = "Previous tab" })

-- Package Management
keymap("n", "<leader>pu", vim.pack.update, { desc = "Update all plugins" })

-- Pickers
keymap("n", "<leader>pf", function()
    MiniPick.builtin.files({ tool = 'rg' })
end, { desc = "Fuzzy find files" })
keymap("n", "<leader>ph", function()
    MiniPick.builtin.help()
end, { desc = "Fuzzy find help" })

-- File system management
keymap("n", "<leader>nt", function()
    -- We do it this way so that there aren't a million errors on the first install
    require("oil").open_float()
end, { desc = "Open a file tree editor" })
