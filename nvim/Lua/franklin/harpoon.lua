local function setup()
    local harpoon = require "harpoon"
    harpoon:setup()
    vim.keymap.set("n", "<Space>a", function() harpoon:list():add() end)
    vim.keymap.set("n", "<Space>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    vim.keymap.set("n", "<Space>1", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<Space>2", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<Space>3", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<Space>4", function() harpoon:list():select(4) end)
    vim.keymap.set("n", "<Space>5", function() harpoon:list():select(5) end)
    vim.keymap.set("n", "<Space>6", function() harpoon:list():select(6) end)
    vim.keymap.set("n", "<Space>7", function() harpoon:list():select(7) end)
    vim.keymap.set("n", "<Space>8", function() harpoon:list():select(8) end)
end

local M = {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = setup
}
return M
