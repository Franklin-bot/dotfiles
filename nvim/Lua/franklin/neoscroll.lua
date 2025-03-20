local function setup()
    local neoscroll = require('neoscroll')
    neoscroll.setup()

    local keymap = {
        ['<leader>j'] = function () neoscroll.ctrl_d({duration = 100, }) end;
        ['<leader>k'] = function () neoscroll.ctrl_u({duration = 100, }) end;
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
