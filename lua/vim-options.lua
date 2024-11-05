vim.opt.compatible = false
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.syntax = "ON"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.encoding = "utf-8"
vim.opt.termguicolors = true

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.inccommand = "split"
vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.signcolumn = "yes"
--vim.opt.clipboard = "unnamedplus"

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- vim.opt.undofile=true
vim.opt.breakindent = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 700
vim.opt.cmdheight = 2

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.title = true
vim.opt.wrap = true
vim.opt.colorcolumn = { 123 }
vim.opt.textwidth = 123

-- spelling check
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }
vim.opt.spelloptions:append({ "camel" })
vim.opt.spellcapcheck = ""

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.g.mapleader = " "
vim.g.mapleaderlocal = " "

vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")

vim.keymap.set("v", "<C-s>", ":sort<CR>")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")

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

------------- quickfix list --------------------
vim.keymap.set("n", "[q", ":cprevious<CR>", {})
vim.keymap.set("n", "]q", ":cnext<CR>", {})
vim.keymap.set("n", "[Q", ":cfirst<CR>", {})
vim.keymap.set("n", "]Q", ":clast<CR>", {})
vim.keymap.set("n", "]u", ":cnewer<CR>", {})
vim.keymap.set("n", "[u", ":colder<CR>", {})

vim.keymap.set("n", "[l", ":lprevious<CR>", {})
vim.keymap.set("n", "]l", ":lnext<CR>", {})
vim.keymap.set("n", "[L", ":lfirst<CR>", {})
vim.keymap.set("n", "]L", ":llast<CR>", {})
-------------------------------------------------

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
