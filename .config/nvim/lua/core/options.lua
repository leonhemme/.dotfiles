vim.opt.nu = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.cursorline = true

vim.opt.scrolloff = 8
vim.opt.termguicolors = true
vim.background = "dark"
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.mouse = ""

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.swapfile = false
