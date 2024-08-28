require("lspconfig").tinymist.setup {
    root_dir = function(fname) return vim.fn.getcwd() end,

    exportPdf = "onType",
    outputPath = "$root/$dir/$name"
}
