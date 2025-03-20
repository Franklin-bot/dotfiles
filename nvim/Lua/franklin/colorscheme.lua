local function setup()
    local poi = require "rose-pine"
    poi.setup()
    vim.cmd.colorscheme "rose-pine"
end

local M = {
    'rose-pine/neovim',
    config = setup
}

return M

