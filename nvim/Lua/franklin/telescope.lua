local function setup()

    local builtin = require('telescope.builtin')
    local actions = require('telescope.actions')

    vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
    vim.keymap.set('n', 'C-p', builtin.git_files, {})
    vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ")});
    end)

end

local M = {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = setup
}

return M
