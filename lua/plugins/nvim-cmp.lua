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
                maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
                ellipsis_char = '...',
                show_labelDetails = true,
                before = function (entry, vim_item)
                    return vim_item
                end
            })
        },
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        preselect = cmp.PreselectMode.None,
        completion = { completeopt = "menu,menuone,noselect" },
        mapping = cmp.mapping.preset.insert({
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ select = false }),
            ["<Tab>"] = cmp.mapping.select_next_item({ behaviour = "select" }),
            ["<S-Tab>"] = cmp.mapping.select_prev_item({ behaviour = "select" }),
        }),
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "nvim_lua" },
            { name = "luasnip" }, -- Snippets
        }, {
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