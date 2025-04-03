local function setup()
    local neoscroll = require('neoscroll')
    neoscroll.setup()

    local keymap = {
        ['<space>j'] = function () neoscroll.scroll(10, {duration = 50, }) end;
        ['<space>k'] = function () neoscroll.scroll(-10, {duration = 50, }) end;
    }

    local modes = { 'n', 'v', 'x' }
    for key, func in pairs(keymap) do
      vim.keymap.set(modes, key, func)
    end

end

local M = {
  "karb94/neoscroll.nvim",
  config = setup
}


return M
