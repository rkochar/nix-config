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

-- map({ "n", "i", "x" }, "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", {
--     remap = false,
--     desc = "Add cursor and move up",
-- })
--
-- map({ "n", "i", "x" }, "<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", {
--     remap = false,
--     desc = "Add cursor and move down",
-- })

-- map({ "n", "i" }, "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", {
--     remap = false,
--     desc = "Add or remove cursor on mouse click",
-- })

map("n", "<C-CR>", "<Cmd>MultipleCursorsAddDelete<CR>", {
    remap = false,
    desc = "Add or remove cursor",
})

map("x", "<leader>mc", "<Cmd>MultipleCursorsAddVisualArea<CR>", {
    remap = false,
    desc = "Add cursors to visual area",
})

map({ "n", "x" }, "<leader>mca", "<Cmd>MultipleCursorsAddMatches<CR>", {
    remap = false,
    desc = "Add cursors to cword",
})

-- select a visual area, esc and then put cursor on word
map({ "n", "x" }, "<leader>mcA", "<Cmd>MultipleCursorsAddMatchesV<CR>", {
    remap = false,
    desc = "Add cursors to cword (previous area)",
})

map({ "n", "x" }, "<leader>mcn", "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", {
    remap = false,
    desc = "Add cursor and jump to next match",
})

map({ "n", "x" }, "<leader>mc]", "<Cmd>MultipleCursorsJumpNextMatch<CR>", {
    remap = false,
    desc = "Jump to next match",
})

map({ "n", "x" }, "<leader>mcN", "<Cmd>MultipleCursorsAddJumpPrevMatch<CR>", {
    remap = false,
    desc = "Add cursor and jump to next match",
})

map({ "n", "x" }, "<leader>mc[", "<Cmd>MultipleCursorsJumpPrevMatch<CR>", {
    remap = false,
    desc = "Jump to next match",
})

-- non-adjoining cursors such as with <c-cr> require unlocking to activate
map({ "n", "x" }, "<leader>mcl", "<Cmd>MultipleCursorsLock<CR>", {
    remap = false,
    desc = "Lock virtual cursors",
})

-- Alignment (Lua API call)
map("n", "<leader>mc|", function()
    mc.align()
end, {
        remap = false,
        desc = "Align multiple cursors",
    })

vim.keymap.set({ "n", "i" }, "<leader>mcgc", function()
    vim.cmd("normal gcc")
end, {
    remap = false,
    desc = "(un)comment line(s)",
})

vim.keymap.set("v", "<leader>mcgc", function()
    vim.cmd("normal gc")
end, {
    remap = false,
    desc = "(un)comment selection",
})
