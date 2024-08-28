require("lspconfig").rust_analyzer.setup{
    settings = {
        ["rust-analyzer"] = {
            highlight = {
                enabled = true
            }
        }
    }
}