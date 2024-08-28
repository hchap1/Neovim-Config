local capabilities = require("cmp_nvim_lsp").default_capabilties(vim.lsp.protocol.make_client_capabilities())

capabilities.textDocument.semanticTokens = {
    dynamicRegistration = false,
    tokenTypes = {},
    tokenModifiers = {},
    formats = {},
    requests = {
        range = true,
        full = true
    },
    multilineTokenSupport = true,
    overlappingTokenSupport = true
}

return capabilities