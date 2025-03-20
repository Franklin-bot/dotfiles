local function setup()

    local entries = 8

    local function generate_indicators(n, get_indicator_function)
        local indicators = {}
        for i = 1, n do
            table.insert(indicators, function (harpoon_entry) return get_indicator_function(i, harpoon_entry) end)
        end

        return indicators
    end

    vim.cmd('highlight LualineInactiveIndicator guifg=#e4f0fb')
    local function get_harpoon_indicator(index, harpoon_entry)
        local path = harpoon_entry.value
        local last_file = path:match("^.+/(.+)$") or path
        return "%#LualineInactiveIndicator#" .. "·"
    end

    vim.cmd('highlight LualineActiveIndicator guifg=#d0679d')
    local function get_active_indicator(index, harpoon_entry)
        local path = harpoon_entry.value
        local last_file = path:match("^.+/(.+)$") or path
        return "%#LualineActiveIndicator#" .. "×"
    end

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
            indicators = generate_indicators(entries, get_harpoon_indicator),
            active_indicators = generate_indicators(entries, get_active_indicator),
            _separator = " ",
            no_harpoon = "Harpoon not loaded",
            fmt = function(str)
                    local utils = require "harpoon-lualine.utils"
                    local harpoon = require("harpoon")

                    local harpoon_entries = harpoon:list()
                    local len = harpoon_entries:length()
                    local total_width = vim.opt.columns:get()

                    local string_length = 2 * len+1
                    local padding = (math.floor(total_width/2) - string_length - mode_width - file_width)

                    -- don't remember why this is here lol
                    -- local current_file_path = vim.api.nvim_buf_get_name(0)
                    -- local root_dir = harpoon_entries.config:get_root_dir()
                    -- if len > 1 then
                    --     for i = 1, len do
                    --         local harpoon_path = harpoon:list():get(i).value
                    --         local full_path = nil
                    --         if utils.is_relative_path(harpoon_path) then
                    --             full_path = utils.get_full_path(root_dir, harpoon_path)
                    --         else
                    --             full_path = harpoon_path
                    --         end
                    --
                    --         if full_path == current_file_path then
                    --             break
                    --         end
                    --     end
                    -- end

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
