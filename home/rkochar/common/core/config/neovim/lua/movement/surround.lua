require("nvim-surround").setup({
    move_cursor = "sticky",
    indent_lines = false,
})

-- r maps to [], q to '' or "" (priority by closest)
-- ys$i/<CR>\ for inserting different characters at start and end
-- s vs S is new line
-- :h nvim-surround.repeating => 3dsq (repeat action thrice), ysiw)W (apply action on current word and on W), 3yss" (apply yss" thrice)

-- :h nvim-surround.aliasing
vim.keymap.set("o", "ir", "i[")
vim.keymap.set("o", "ar", "a[")
vim.keymap.set("o", "ia", "i<")
vim.keymap.set("o", "aa", "a<")
