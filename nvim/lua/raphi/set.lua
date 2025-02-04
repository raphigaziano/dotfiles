vim.opt.guicursor       = ""
vim.opt.cursorline      = true

vim.opt.nu 		        = true
vim.opt.relativenumber 	= true

vim.opt.showmatch       = true -- show matching brackets
vim.opt.ignorecase      = true -- case insensitive
vim.opt.smartcase       = true -- smart case matching

-- vim.opt.wildignore      += *.o,*.swp

vim.opt.tabstop 	= 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth 	= 4
vim.opt.expandtab 	= true

vim.opt.smartindent = true

vim.opt.wrap        = false

vim.opt.swapfile    = false
vim.opt.backup      = false
vim.opt.undodir     = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile    = true

vim.opt.hlsearch    = true
vim.opt.incsearch   = true

vim.opt.termguicolors = true

vim.opt.scrolloff   = 8
vim.opt.signcolumn  = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime  = 20

vim.opt.colorcolumn = "80"

vim.opt.mouse       = 'a'
