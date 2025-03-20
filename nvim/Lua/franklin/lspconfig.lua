local function setup()

    local lspconfig = require "lspconfig"
    local cmp = require "cmp"
    local servers = {"lua_ls", "clangd", "pyright", "gopls"}

    require("mason").setup()
    require("mason-lspconfig").setup {
        ensure_installed = servers
    }

    -- configure servers
    for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
            on_attach = function(client, bufr)
                client.server_capabilities.semanticTokensProvider = nil
            end
        })

    end

    -- configure autocomplete
    cmp.setup({
        snippet = {
              expand = function(args)
                 vim.fn["vsnip#anonymous"](args.body)
              end,
        },
        window = {
            completion = cmp.config.window.bordered({border = "none"})
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
        }, {
          { name = 'buffer' },
        }),

        mapping = {
            ['<C-k>'] = cmp.mapping.select_prev_item(),
            ['<C-j>'] = cmp.mapping.select_next_item(),
            ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
        }
    })

end

local M = {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/vim-vsnip" },
        { "hrsh7th/vim-vsnip-integ" }
    },
    config = setup,
}

return M
