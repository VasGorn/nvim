vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

vim.cmd("set number")
vim.cmd("set relativenumber")

vim.cmd("set encoding=UTF-8")
vim.cmd("set noswapfile")
vim.cmd("set nobackup")
vim.cmd("set termguicolors")

vim.g.mapleader = " "
vim.g.mapleaderlocal = " "

vim.keymap.set('n', '[b', ':bprevious<CR>', {})
vim.keymap.set('n', ']b', ':bnext<CR>', {})
vim.keymap.set('n', '[B', ':bfirst<CR>', {})
vim.keymap.set('n', ']B', ':blast<CR>', {})


