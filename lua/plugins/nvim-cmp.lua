local M = {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        -- Snippets
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = "make install_jsregexp"
        },
        "dcampos/nvim-snippy",
        "honza/vim-snippets",

        -- LSPs
        "zjp-CN/nvim-cmp-lsp-rs", -- Rust analyzer result filtering and sorting
    },
}

M.config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")
    vim.opt.completeopt = { "menu", "menuone", "noselect" }

    cmp.setup({
        formatting = {
            format = lspkind.cmp_format({
                mode = "symbol_text",
                -- can also be a function to dynamically calculate max width such as 
                maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
                ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                show_labelDetails = true, -- show labelDetails in menu. Disabled by default

                -- The function below will be called before any actual modifications from lspkind
                -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                before = function (entry, vim_item)
                    return vim_item
                end
            })
        },
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
            end,
        },
		preselect = cmp.PreselectMode.None,
		completion = { completeopt = "menu,menuone,noselect" },
        window = {
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ["<Tab>"] = cmp.mapping.select_next_item({ behaviour = "select" }),
            ["<S-Tab>"] = cmp.mapping.select_prev_item({ behaviour = "select" }),
        }),
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "nvim_lua" },
            { name = "luasnip" }, -- For luasnip users.
        },
            {
                { name = "buffer" },
                { name = "path" },
            }),
    })

    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = "path" },
        }, {
                { name = "cmdline" },
            }),
    })
end

return M
