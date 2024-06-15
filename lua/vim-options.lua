vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

vim.cmd("set number")
vim.cmd("set relativenumber")

vim.cmd("set encoding=UTF-8")
vim.cmd("set termguicolors")

vim.cmd("set noswapfile")
vim.cmd("set nobackup")

vim.cmd("set inccommand=split")
vim.cmd("set smartcase")
vim.cmd("set ignorecase")

vim.cmd("set splitbelow")
vim.cmd("set splitright")

vim.cmd("set signcolumn=yes")
vim.cmd("set clipboard=unnamedplus")

vim.g.mapleader = " "
vim.g.mapleaderlocal = " "

-- change navigation between splits
vim.keymap.set("n", "<c-j>", "<c-w><c-j>")
vim.keymap.set("n", "<c-k>", "<c-w><c-k>")
vim.keymap.set("n", "<c-l>", "<c-w><c-l>")
vim.keymap.set("n", "<c-h>", "<c-w><c-h>")

vim.keymap.set("n", "<M-,>", "<c-w>5<")
vim.keymap.set("n", "<M-.>", "<c-w>5>")
vim.keymap.set("n", "<M-t>", "<C-W>+")
vim.keymap.set("n", "<M-s>", "<C-W>-")

vim.keymap.set("n", "[b", ":bprevious<CR>", {})
vim.keymap.set("n", "]b", ":bnext<CR>", {})
vim.keymap.set("n", "[B", ":bfirst<CR>", {})
vim.keymap.set("n", "]B", ":blast<CR>", {})

vim.keymap.set("n", "[q", ":cprevious<CR>", {})
vim.keymap.set("n", "]q", ":cnext<<CR>", {})
vim.keymap.set("n", "[Q", ":cfirst<<CR>", {})
vim.keymap.set("n", "]Q", ":clast<CR>", {})
vim.keymap.set("n", "]u", ":cnewer<CR>", {})
vim.keymap.set("n", "[u", ":colder<CR>", {})

vim.keymap.set("n", "[l", ":lprevious<CR>", {})
vim.keymap.set("n", "]l", ":lnext<<CR>", {})
vim.keymap.set("n", "[L", ":lfirst<<CR>", {})
vim.keymap.set("n", "]L", ":llast<CR>", {})

vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)

