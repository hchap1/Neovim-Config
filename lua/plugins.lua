return {
    require("plugins.nvim-cmp"),
    require("plugins.lsp-zero"),
	require("plugins.onedark"),
	require("plugins.tokyonight"),
    require("plugins.tundra"),
    require("plugins.treesitter"),
    require("plugins.screenkey"),
    require("plugins.barbar"),
    -- Removed until illegal character patch: require("plugins.lualine"),
	require("plugins.galaxyline"), -- Lualine alternative
    require("plugins.lspkind"),
    require("plugins.typst-preview"),
    require("plugins.telescope"),
    require("plugins.notify"),
    require("plugins.transparent"),
    require("plugins.autopair"),
    require("plugins.notify"),
    require("plugins.hover")
}
