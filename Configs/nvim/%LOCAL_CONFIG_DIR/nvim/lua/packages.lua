vim.pack.add({
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin-nvim" },
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/folke/which-key.nvim",
    "https://github.com/lukas-reineke/indent-blankline.nvim",
    "https://github.com/echasnovski/mini.pick",

    -- Dependencies
    "https://github.com/nvim-tree/nvim-web-devicons", -- which-key.nvim, mini.pick
})

vim.cmd("colorscheme catppuccin-mocha")

require("oil").setup({
    view_options = {
        show_hidden = true
    }
})
draw = {
    delay = 20
}
require("which-key").setup({
    preset = "modern",

    win = {
        no_overlap = true
    }
})
require("ibl").setup({
    scope = { enabled = false }
})

local picker_win_config = function()
    local height = math.floor(0.618 * vim.opt.lines:get())
    local width = math.floor(0.618 * vim.opt.columns:get())

    return {
        anchor = "NW",
        height = height,
        width = width,
        row = math.floor(0.5 * (vim.opt.lines:get() - height)),
        col = math.floor(0.5 * (vim.opt.columns:get() - width))
    }
end
require("mini.pick").setup({
    mappings = {
        move_down = "<C-j>",
        move_up = "<C-k>",
    },

    options = {
        use_cache = true
    },

    window = {
        config = picker_win_config
    }
})
