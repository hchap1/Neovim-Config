vim.o.termguicolors = true -- 24 bit colour
vim.opt.mouse = ""
vim.o.expandtab = false -- Use spaces instead of tabs
vim.o.ts = 4 -- How many spaces in a tab
vim.o.sw = 4 -- How many spaces used during autoindent
vim.o.scrolloff = 6 -- How many lines to keep above/below the cursor when scrolling
vim.o.number = true -- Line numbers
vim.o.relativenumber = false -- Relative line numbers
vim.o.smarttab = true -- Smart tab
vim.o.wildmenu = true -- Show completion options in command mode
vim.o.wildmode = "longest,full"
vim.o.lbr = true -- Wrap at smart points rather than just the last character that fits
vim.o.showmatch = false -- Briefly move to the matching bracket when closing it
vim.o.wmh = 0 -- Minimum subwindow size
vim.o.cursorline = true -- Highlight the line that the cursor is on
vim.o.encoding = "UTF-8"
vim.o.autoindent = true -- Auto-indent when making new lines
-- Due to the way neovim loads formatoptins, set it upon entering any buffer
vim.api.nvim_create_autocmd({"BufEnter","BufWinEnter"},{pattern={"*"},callback=function()
	vim.o.formatoptions = "qn1"
end})

-- Status line (if lualine fails to load)
vim.o.ruler = true -- Line and column numbers on the status line
