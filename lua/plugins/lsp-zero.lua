M = {
    'VonHeikemen/lsp-zero.nvim', branch = 'v4.x',
    dependencies = {
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},
        {'neovim/nvim-lspconfig'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/nvim-cmp'},
		{
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = "make install_jsregexp"
        },
        "dcampos/nvim-snippy",
        "honza/vim-snippets",

        -- LSPs
        "zjp-CN/nvim-cmp-lsp-rs",
    }
}

local lsp_attach = function (client, bufnr)
    local opts = {buffer = bufnr}
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
end

M.config = function ()
    local lsp_zero = require('lsp-zero')
    lsp_zero.extend_lspconfig({
        sign_text = true,
        lsp_attach = lsp_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
    })

    require('mason').setup({})
    require('mason-lspconfig').setup({
        ensure_installed = {"rust_analyzer", "lua_ls", "tinymist" },
        handlers = {
            function(server_name)
                require('lspconfig')[server_name].setup({
                    root_dir = function() return vim.fn.getcwd() end,
                    on_attach = lsp_attach,
                    capabilities = require('cmp_nvim_lsp').default_capabilities()
                })
            end,
            rust_analyzer = function() require("lsp.rust_analyzer") end,
            tinymist = function() require("lsp.tinymist") end,
            lua_ls = function() require("lsp.lua_ls") end,
        },
    })
end

return M
