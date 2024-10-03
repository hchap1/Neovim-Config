-- Key mappings
vim.api.nvim_set_keymap('n', '`<CR>', ':wincmd w<CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '``', ':TypstPreviewStop<CR> :TypstPreview<CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<CR>b', ':bn<CR>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<F5>', '<cmd>lua ' ..
    'local file_name = vim.fn.expand("%:t") ' ..
    'if file_name:match("%.py$") then ' ..
        'vim.api.nvim_command("!python %") ' ..
    'elseif file_name:match("%.rs$") then ' ..
        'vim.api.nvim_command("!cargo build") ' ..
    'else ' ..
        'print("Unsupported file type") ' ..
    'end<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '`2', '<cmd>lua ' ..
    'local file_name = vim.fn.expand("%:t") ' ..
    'if file_name:match("%.typ$") then ' ..
        'vim.api.nvim_command("!typst-spell-check % --report") ' ..
	'end<CR>', {noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '`1', ':TypstPreview<CR>', { noremap = true, silent = false} )
vim.api.nvim_set_keymap('n', '<CR>f', ':Telescope find_files<CR>', { noremap = true, silent = false} )
