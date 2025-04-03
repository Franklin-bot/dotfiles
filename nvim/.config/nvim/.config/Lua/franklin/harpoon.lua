local function setup()

    local harpoon = require("harpoon")
    local entries = 8

    harpoon:setup()

    vim.keymap.set("n", "<Space>a", function() harpoon:list():add() end)
    vim.keymap.set("n", "<Space>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    for i=1, entries do
        vim.keymap.set("n", "<Space>"..i, function() harpoon:list():select(i) end)
    end
end

local M = {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = setup
}
return M
