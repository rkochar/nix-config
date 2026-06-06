vim.opt.compatible = false
-- vim.opt.swapfile = false
vim.g.mapleader = '\\'
vim.g.maplocalleader = ','
-- :verbose imap j

vim.opt.relativenumber = true
vim.keymap.set({'n', 'i', 'v'}, '<leader>L', '<CMD>set invrelativenumber<CR>', {desc = 'Toggle number and relative number', remap = false})
-- https://www.reddit.com/r/neovim/comments/1d16sx1/can_absolute_and_relative_line_numbers_be_used/
vim.opt.statuscolumn = "%=%{v:relnum ? v:relnum : v:lnum}%=%s"  -- Show absolute number for current line and relative for others
vim.opt.selection = "inclusive"  -- inclusive adds an extra line

vim.opt.wrap = true
vim.opt.showbreak = '+++'
vim.opt.formatoptions = 'tcqrn1'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftround = false

vim.opt.listchars = {
    tab = '>-',
    eol = '¬',
    multispace = '---+',
    trail = 'X'
}
vim.keymap.set('n', '<leader>l', '<CMD>set list!<CR>', {desc = 'Toggle tabs and EOL', remap = false})

vim.opt.cursorline = true
-- minimum lines to keep at top of window when scrolling
-- vim.opt.scrolloff = 4
vim.keymap.set('n', 'j', 'gj', {desc = 'Move editor lines when wrapped', remap = false})
vim.keymap.set('n', 'k', 'gk', {desc = 'Move editor lines when wrapped', remap = false})
vim.opt.startofline = true

vim.opt.hidden = true  -- preserve buffers
vim.opt.laststatus = 2
vim.opt.showmode = true
vim.opt.showcmd = true
vim.opt.showtabline = 2
vim.opt.ruler = true

vim.opt.hlsearch = true
vim.keymap.set('n', '<leader> ', '<CMD>nohlsearch<CR>', {desc = 'Remove search highlights', remap = false})
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmatch = true  -- briefly jump to matching bracket on insert

vim.opt.splitright = true
vim.opt.splitbelow = true
-- TODO: neovim does not source ~/.zshenv which defines SHELL
vim.keymap.set('n', '<leader>t', '<CMD>sp term://zsh<CR>', {desc = 'Open terminal inside vim', remap = false})
vim.keymap.set('n', '<leader>vt', '<CMD>vsp term://zsh<CR>', {desc = 'Open terminal inside vim (vertical split)', remap = false})
-- <c-w>{kjhl} works well.
-- vim.keymap.set('n', '<c-k>', '<CMD>wincmd k<CR>', {desc = 'Move to window above', remap = false})
-- vim.keymap.set('n', '<c-j>', '<CMD>wincmd j<CR>', {desc = 'Move to window below', remap = false})
-- vim.keymap.set('n', '<c-h>', '<CMD>wincmd h<CR>', {desc = 'Move to window left', remap = false})
-- vim.keymap.set('n', '<c-l>', '<CMD>wincmd l<CR>', {desc = 'Move to window right', remap = false})

vim.keymap.set('n', '<leader>q', '<CMD>q<CR>', {desc = 'Quit', remap = false})
vim.keymap.set('n', '<leader>qa', '<CMD>qa<CR>', {desc = 'Quit All', remap = false})
vim.keymap.set({'n', 'i'}, '<leader>w', '<CMD>w<CR>', {desc = 'Write', remap = false})
vim.keymap.set({'n', 'i'}, '<leader>wa', '<CMD>wa<CR>', {desc = 'Write All', remap = false})
vim.keymap.set({'n', 'i'}, '<leader>x', '<CMD>x<CR>', {desc = 'Write and Quit', remap = false})
vim.keymap.set({'n', 'i'}, '<leader>xa', '<CMD>xa<CR>', {desc = 'Write and Quit All', remap = false})
vim.keymap.set({'n', 'i', 'v', 'o', 'c'}, '<leader>z', '<c-z>', {desc = 'Move vim into a background process and go to terminal', remap = false})
vim.keymap.set('i', 'jk', '<esc>', {desc = 'Bind jk to escape', remap = false})
-- vim.keymap.set({'n', 'i', 'v', 'o', 'c'}, 'kj', '<CMD>x<CR>', {desc = 'Bind kj to save + quit file', remap = false})

vim.keymap.set('n', '<c-d>', 'ddi', {desc = 'Delete current line in insert mode', remap = false})

require("treesitter.init")
require("decoration.init")
require("movement.init")
require("filesystem.init")
require("theme.onedark")
