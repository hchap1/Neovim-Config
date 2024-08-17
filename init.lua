-- Bootstrap lazy.nvim

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- Setup lazy.nvim
require("lazy").setup({
  'neovim/nvim-lspconfig',
  spec = {
    { 'neovim/nvim-lspconfig' },    -- LSP configurations
    { 'hrsh7th/nvim-cmp' },         -- Completion plugin
    { 'hrsh7th/cmp-nvim-lsp' },     -- LSP source for nvim-cmp
    { 'hrsh7th/cmp-buffer' },       -- Buffer completions
    { 'hrsh7th/cmp-path' },         -- Path completions
    { 'hrsh7th/cmp-cmdline' },      -- Command-line completions
    { 'L3MON4D3/LuaSnip' },         -- Snippets plugin
    { 'saadparwaiz1/cmp_luasnip' }, -- Snippets source for nvim-cmp
    { 'navarasu/onedark.nvim' },    -- Atom One Dark theme
    { 'kaarmu/typst.vim' },  	    -- Typst syntax highlighting
    { 'nvim-treesitter/nvim-treesitter'},
    { 'chomosuke/typst-preview.nvim' },
    { 'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons' },
    { 'nvim-lualine/lualine.nvim', dependencies = 'nvim-tree/nvim-web-devicons' },
    {
	   "m4xshen/hardtime.nvim",
	   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
	   opts = {}
	},
  },
  install = { colorscheme = { "onedark" } },
  checker = { enabled = true },
})
vim.opt.termguicolors = true
require("bufferline").setup{}
require("hardtime").setup()
require('lualine').setup()
require('nvim-treesitter.configs').setup {
    -- A list of parser names, or "all" (the four listed parsers should always be installed)
    ensure_installed = { "c", "lua", "vim", "python", "rust", "html"},

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    highlight = {
        -- `false` will disable the whole extension
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

-- Configure the theme
require('onedark').setup {
  style = 'darker',
  code_style = {
    comments = 'italic',
  },
}
require('onedark').load()

-- Setup LSP for Rust using nvim-lspconfig
local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.semanticTokens = { dynamicRegistration = false, tokenTypes = {}, tokenModifiers = {}, formats = {}, requests = { range = true, full = true }, multilineTokenSupport = false, overlappingTokenSupport = false }

nvim_lsp.typst_lsp.setup({
  capabilities = capabilities,
})

nvim_lsp.rust_analyzer.setup({
    capabilities = capabilities,
    settings = {
        ['rust-analyzer'] = {
            highlight = {
                enabled = true,
            },
        },
    },
})

nvim_lsp.pyright.setup({
    capabilities = capabilities,
    settings = {
        python = {
            analysis = {
                semanticTokens = true,
            },
        },
    },
})

-- Setup nvim-cmp
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

vim.api.nvim_set_keymap('n', '``', ':wincmd w<CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<CR>b', ':bn <CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<F5>', '<cmd>lua ' ..
    'local file_name = vim.fn.expand("%:t") ' ..
    'if file_name:match("%.py$") then ' ..
        'vim.api.nvim_command("!python %") ' ..
    'elseif file_name:match("%.rs$") then ' ..
    	'vim.api.nvim_command("term") ' ..
        'vim.api.nvim_command("!cargo build") ' ..
    'else ' ..
        'print("Unsupported file type") ' ..
    'end<CR>', { noremap = true, silent = true })

-- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
vim.cmd("set number")

vim.cmd [[
augroup filetypedetect
    autocmd! BufRead,BufNewFile *.typ setfiletype typst
augroup END
]]


vim.g.neovide_cursor_animate_command_line = false
vim.g.neovide_cursor_animation_length = 0.08
vim.g.neovide_cursor_trail_size = 0.5
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- Setup lazy.nvim
require("lazy").setup({
  'neovim/nvim-lspconfig',
  spec = {
    { 'neovim/nvim-lspconfig' },    -- LSP configurations
    { 'hrsh7th/nvim-cmp' },         -- Completion plugin
    { 'hrsh7th/cmp-nvim-lsp' },     -- LSP source for nvim-cmp
    { 'hrsh7th/cmp-buffer' },       -- Buffer completions
    { 'hrsh7th/cmp-path' },         -- Path completions
    { 'hrsh7th/cmp-cmdline' },      -- Command-line completions
    { 'L3MON4D3/LuaSnip' },         -- Snippets plugin
    { 'saadparwaiz1/cmp_luasnip' }, -- Snippets source for nvim-cmp
    { 'navarasu/onedark.nvim' },    -- Atom One Dark theme
    { 'kaarmu/typst.vim' },  	    -- Typst syntax highlighting
    { 'nvim-treesitter/nvim-treesitter'},
    { 'chomosuke/typst-preview.nvim' },
    { 'akinsho/bufferline.nvim.git', version = "*", dependencies = 'nvim-tree/nvim-web-devicons' },
    {
	   "m4xshen/hardtime.nvim",
	   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
	   opts = {}
	},
  },
  install = { colorscheme = { "onedark" } },
  checker = { enabled = true },
})
require("hardtime").setup()
require('nvim-treesitter.configs').setup {
    -- A list of parser names, or "all" (the four listed parsers should always be installed)
    ensure_installed = { "c", "lua", "vim", "python", "rust", "html"},

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    highlight = {
        -- `false` will disable the whole extension
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

-- Configure the theme
require('onedark').setup {
  style = 'darker',
  code_style = {
    comments = 'italic',
  },
}
require('onedark').load()

-- Setup LSP for Rust using nvim-lspconfig
local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.semanticTokens = { dynamicRegistration = false, tokenTypes = {}, tokenModifiers = {}, formats = {}, requests = { range = true, full = true }, multilineTokenSupport = false, overlappingTokenSupport = false }

nvim_lsp.typst_lsp.setup({
  capabilities = capabilities,
})

nvim_lsp.rust_analyzer.setup({
    capabilities = capabilities,
    settings = {
        ['rust-analyzer'] = {
            highlight = {
                enabled = true,
            },
        },
    },
})

nvim_lsp.pyright.setup({
    capabilities = capabilities,
    settings = {
        python = {
            analysis = {
                semanticTokens = true,
            },
        },
    },
})

-- Setup nvim-cmp
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

vim.api.nvim_set_keymap('n', '``', ':wincmd w<CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<F5>', '<cmd>lua ' ..
    'local file_name = vim.fn.expand("%:t") ' ..
    'if file_name:match("%.py$") then ' ..
        'vim.api.nvim_command("!python %") ' ..
    'elseif file_name:match("%.rs$") then ' ..
    	'vim.api.nvim_command("term") ' ..
        'vim.api.nvim_command("!cargo build") ' ..
    'else ' ..
        'print("Unsupported file type") ' ..
    'end<CR>', { noremap = true, silent = true })

-- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
vim.cmd("set number")

vim.cmd [[
augroup filetypedetect
    autocmd! BufRead,BufNewFile *.typ setfiletype typst
augroup END
]]


vim.g.neovide_cursor_animate_command_line = false
vim.g.neovide_cursor_animation_length = 0.08
vim.g.neovide_cursor_trail_size = 0.5
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- Setup lazy.nvim
require("lazy").setup({
  'neovim/nvim-lspconfig',
  spec = {
    { 'neovim/nvim-lspconfig' },    -- LSP configurations
    { 'hrsh7th/nvim-cmp' },         -- Completion plugin
    { 'hrsh7th/cmp-nvim-lsp' },     -- LSP source for nvim-cmp
    { 'hrsh7th/cmp-buffer' },       -- Buffer completions
    { 'hrsh7th/cmp-path' },         -- Path completions
    { 'hrsh7th/cmp-cmdline' },      -- Command-line completions
    { 'L3MON4D3/LuaSnip' },         -- Snippets plugin
    { 'saadparwaiz1/cmp_luasnip' }, -- Snippets source for nvim-cmp
    { 'navarasu/onedark.nvim' },    -- Atom One Dark theme
    { 'kaarmu/typst.vim' },  	    -- Typst syntax highlighting
    { 'nvim-treesitter/nvim-treesitter'},
    { 'chomosuke/typst-preview.nvim' },
    { 'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons' },
    { 'nvim-lualine/lualine.nvim', dependencies = 'nvim-tree/nvim-web-devicons' },
    {
	   "m4xshen/hardtime.nvim",
	   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
	   opts = {}
	},
  },
  install = { colorscheme = { "onedark" } },
  checker = { enabled = true },
})
vim.opt.termguicolors = true
require("bufferline").setup{}
require("hardtime").setup()
require('nvim-treesitter.configs').setup {
    -- A list of parser names, or "all" (the four listed parsers should always be installed)
    ensure_installed = { "c", "lua", "vim", "python", "rust", "html"},

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    highlight = {
        -- `false` will disable the whole extension
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

-- Configure the theme
require('onedark').setup {
  style = 'darker',
  code_style = {
    comments = 'italic',
  },
}
require('onedark').load()

-- Setup LSP for Rust using nvim-lspconfig
local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.semanticTokens = { dynamicRegistration = false, tokenTypes = {}, tokenModifiers = {}, formats = {}, requests = { range = true, full = true }, multilineTokenSupport = false, overlappingTokenSupport = false }

nvim_lsp.typst_lsp.setup({
  capabilities = capabilities,
})

nvim_lsp.rust_analyzer.setup({
    capabilities = capabilities,
    settings = {
        ['rust-analyzer'] = {
            highlight = {
                enabled = true,
            },
        },
    },
})

nvim_lsp.pyright.setup({
    capabilities = capabilities,
    settings = {
        python = {
            analysis = {
                semanticTokens = true,
            },
        },
    },
})

-- Setup nvim-cmp
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

vim.api.nvim_set_keymap('n', '``', ':wincmd w<CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<F5>', '<cmd>lua ' ..
    'local file_name = vim.fn.expand("%:t") ' ..
    'if file_name:match("%.py$") then ' ..
        'vim.api.nvim_command("!python %") ' ..
    'elseif file_name:match("%.rs$") then ' ..
    	'vim.api.nvim_command("term") ' ..
        'vim.api.nvim_command("!cargo build") ' ..
    'else ' ..
        'print("Unsupported file type") ' ..
    'end<CR>', { noremap = true, silent = true })

-- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
vim.cmd("set number")

vim.cmd [[
augroup filetypedetect
    autocmd! BufRead,BufNewFile *.typ setfiletype typst
augroup END
]]


vim.g.neovide_cursor_animate_command_line = false
vim.g.neovide_cursor_animation_length = 0.08
vim.g.neovide_cursor_trail_size = 0.5
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- Setup lazy.nvim
require("lazy").setup({
  'neovim/nvim-lspconfig',
  spec = {
    { 'neovim/nvim-lspconfig' },    -- LSP configurations
    { 'hrsh7th/nvim-cmp' },         -- Completion plugin
    { 'hrsh7th/cmp-nvim-lsp' },     -- LSP source for nvim-cmp
    { 'hrsh7th/cmp-buffer' },       -- Buffer completions
    { 'hrsh7th/cmp-path' },         -- Path completions
    { 'hrsh7th/cmp-cmdline' },      -- Command-line completions
    { 'L3MON4D3/LuaSnip' },         -- Snippets plugin
    { 'saadparwaiz1/cmp_luasnip' }, -- Snippets source for nvim-cmp
    { 'navarasu/onedark.nvim' },    -- Atom One Dark theme
    { 'kaarmu/typst.vim' },  	    -- Typst syntax highlighting
    { 'nvim-treesitter/nvim-treesitter'},
    { 'chomosuke/typst-preview.nvim' },
    { 'akinsho/bufferline.nvim.git', version = "*", dependencies = 'nvim-tree/nvim-web-devicons' },
    {
	   "m4xshen/hardtime.nvim",
	   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
	   opts = {}
	},
  },
  install = { colorscheme = { "onedark" } },
  checker = { enabled = true },
})
require("hardtime").setup()
require('nvim-treesitter.configs').setup {
    -- A list of parser names, or "all" (the four listed parsers should always be installed)
    ensure_installed = { "c", "lua", "vim", "python", "rust", "html"},

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    highlight = {
        -- `false` will disable the whole extension
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

-- Configure the theme
require('onedark').setup {
  style = 'darker',
  code_style = {
    comments = 'italic',
  },
}
require('onedark').load()

-- Setup LSP for Rust using nvim-lspconfig
local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.semanticTokens = { dynamicRegistration = false, tokenTypes = {}, tokenModifiers = {}, formats = {}, requests = { range = true, full = true }, multilineTokenSupport = false, overlappingTokenSupport = false }

nvim_lsp.typst_lsp.setup({
  capabilities = capabilities,
})

nvim_lsp.rust_analyzer.setup({
    capabilities = capabilities,
    settings = {
        ['rust-analyzer'] = {
            highlight = {
                enabled = true,
            },
        },
    },
})

nvim_lsp.pyright.setup({
    capabilities = capabilities,
    settings = {
        python = {
            analysis = {
                semanticTokens = true,
            },
        },
    },
})

-- Setup nvim-cmp
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

vim.api.nvim_set_keymap('n', '``', ':wincmd w<CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<F5>', '<cmd>lua ' ..
    'local file_name = vim.fn.expand("%:t") ' ..
    'if file_name:match("%.py$") then ' ..
        'vim.api.nvim_command("!python %") ' ..
    'elseif file_name:match("%.rs$") then ' ..
    	'vim.api.nvim_command("term") ' ..
        'vim.api.nvim_command("!cargo build") ' ..
    'else ' ..
        'print("Unsupported file type") ' ..
    'end<CR>', { noremap = true, silent = true })

-- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
vim.cmd("set number")

vim.cmd [[
augroup filetypedetect
    autocmd! BufRead,BufNewFile *.typ setfiletype typst
augroup END
]]


vim.g.neovide_cursor_animate_command_line = false
vim.g.neovide_cursor_animation_length = 0.08
vim.g.neovide_cursor_trail_size = 0.5
