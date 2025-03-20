local function setup()
    require'nvim-treesitter.configs'.setup {
    ensure_installed = {"javascript", "c", "cpp", "lua", "vim", "python", "go"},
    sync_install = true,
    auto_install = true,
    ignore_install = { "help" },
    highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
end

local M = {
    'nvim-treesitter/nvim-treesitter',
    config = setup
}

return M
