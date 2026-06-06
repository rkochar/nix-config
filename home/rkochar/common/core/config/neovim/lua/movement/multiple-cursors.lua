local map = vim.keymap.set
local mc = require("multiple-cursors")

mc.setup({})

map({ "n", "x" }, "<C-j>", "<Cmd>MultipleCursorsAddDown<CR>", {
    remap = false,
    desc = "Add cursor and move down",
})

map({ "n", "x" }, "<C-k>", "<Cmd>MultipleCursorsAddUp<CR>", {
    remap = false,
    desc = "Add cursor and move up",
})

map({ "n", "i", "x" }, "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", {
    remap = false,
    desc = "Add cursor and move up",
})

map({ "n", "i", "x" }, "<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", {
    remap = false,
    desc = "Add cursor and move down",
})

map({ "n", "i" }, "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", {
    remap = false,
    desc = "Add or remove cursor on mouse click",
})

map("n", "<C-CR>", "<Cmd>MultipleCursorsAddDelete<CR>", {
    remap = false,
    desc = "Add or remove cursor",
})

map("x", "<Leader>m", "<Cmd>MultipleCursorsAddVisualArea<CR>", {
    remap = false,
    desc = "Add cursors to visual area",
})

map({ "n", "x" }, "<Leader>a", "<Cmd>MultipleCursorsAddMatches<CR>", {
    remap = false,
    desc = "Add cursors to cword",
})

map({ "n", "x" }, "<Leader>A", "<Cmd>MultipleCursorsAddMatchesV<CR>", {
    remap = false,
    desc = "Add cursors to cword (previous area)",
})

map({ "n", "x" }, "<Leader>d", "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", {
    remap = false,
    desc = "Add cursor and jump to next match",
})

map({ "n", "x" }, "<Leader>D", "<Cmd>MultipleCursorsJumpNextMatch<CR>", {
    remap = false,
    desc = "Jump to next match",
})

map({ "n", "x" }, "<Leader>l", "<Cmd>MultipleCursorsLock<CR>", {
    remap = false,
    desc = "Lock virtual cursors",
})

-- Alignment (Lua API call)
map("n", "<Leader>|", function()
    mc.align()
end, {
        remap = false,
        desc = "Align multiple cursors",
    })
