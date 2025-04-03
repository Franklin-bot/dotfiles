local function setup()

    local entries = 8
    local inactive_icon = "·"
    local active_icon = "×"
    -- local active_icon = "🍆"

    local function generate_indicators(n, get_indicator_function)
        local indicators = {}
        for i = 1, n do
            table.insert(indicators, get_indicator_function())
        end
        return indicators
    end

    vim.cmd('highlight LualineInactiveIndicator guifg=#e4f0fb')
    vim.cmd('highlight LualineActiveIndicator guifg=#d0679d')

    -- elements
    local mode_width = 0
    local mode = {
        "mode",
        fmt = function(str)
            mode_width = #str
            return str
        end
        }

    local file_width = 0
    local filename = {
        "filename",
        symbols = {
          modified = '',      -- Text to show when the file is modified.
          readonly = '',      -- Text to show when the file is non-modifiable or readonly.
          unnamed = '[No Name]', -- Text to show for unnamed buffers.
       },
        fmt = function(str)
            file_width = #str
            return str
        end
        }

    local hll =
        {
            "harpoon2",
            indicators = generate_indicators(entries, function() return "%#LualineInactiveIndicator#" .. inactive_icon end ),
            active_indicators = generate_indicators(entries, function () return "%#LualineActiveIndicator#" .. active_icon end ),
            _separator = " ",
            no_harpoon = "Harpoon not loaded",
            fmt = function(str)
                    local harpoon = require("harpoon")
                    local harpoon_len = 2*harpoon:list():length()+1
                    local total_width = vim.opt.columns:get()

                    local padding = (math.floor(total_width/2) - harpoon_len - mode_width - file_width)
                    str = string.rep(" ", padding) .. str
                    return str
                end,
        }

    local branch = {
        "branch",
        }

    local diff =
            {
                'diff',
                colored = true,
                always_visible = true,
                symbols = {added = '+', modified = '~', removed = '-'},
                diff_color = {
                    added    = { fg = '#ADD7FF', bg = '#282c34' }, -- Green foreground, custom background
                    modified = { fg = '#e4f0fb', bg = '#282c34' }, -- Yellow foreground, custom background
                    removed  = { fg = '#d0679d', bg = '#282c34' }, -- Red foreground, custom background
                },
            }

    local default_refresh_events = {
                'WinEnter',
                'BufEnter',
                'BufWritePost',
                'SessionLoadPost',
                'FileChangedShellPost',
                'VimResized',
                'Filetype',
                'CursorMoved',
                'CursorMovedI',
                'ModeChanged',
            }
    vim.api.nvim_create_autocmd(default_refresh_events, {
        group = vim.api.nvim_create_augroup('LualineRefreshEvents', { clear = true }),
        callback = function()
            vim.schedule(function()
                require('lualine').refresh()
            end)
        end,
    })
    vim.cmd('set cmdheight=0')

    -- configure lualine
    require('lualine').setup {
        options = {
            icons_enabled = false,
            component_separators = '',
            section_separators = '',
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
                statusline = 100,
                tabline = 1000,
                winbar = 1000,
            }
        },
        sections = {
            lualine_a = {mode},
            lualine_b = {filename},
            lualine_c = {hll},
            lualine_x = {},
            lualine_y = {branch},
            lualine_z = {diff},
        },
    }

end

local M = {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = setup
}

return M
