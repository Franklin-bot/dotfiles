local function setup()
  require("rose-pine").setup()
  vim.cmd("colorscheme rose-pine")
end

local M = {
  'rose-pine/neovim',
  config = setup
}

return M
