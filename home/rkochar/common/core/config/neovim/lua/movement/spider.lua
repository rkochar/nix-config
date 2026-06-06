require("spider").setup {
	skipInsignificantPunctuation = true,
	subwordMovement = true,
	consistentOperatorPending = false, -- see the README for details
	customPatterns = {}, -- see the README for details
}

local motion

local function spider_motion(key)
  motion = motion or require("spider").motion
  motion(key)
end

vim.keymap.set({ "n", "o", "x" }, "w", function()
  spider_motion("w")
end)

vim.keymap.set({ "n", "o", "x" }, "e", function()
  spider_motion("e")
end)

vim.keymap.set({ "n", "o", "x" }, "b", function()
  spider_motion("b")
end)

vim.keymap.set({ "n", "o", "x" }, "ge", function()
  spider_motion("ge")
end)

vim.keymap.set("i", "<C-f>", function()
  vim.cmd("normal! <Esc>l")
  motion("w")
  vim.cmd("startinsert")
end)

vim.keymap.set("i", "<C-b>", function()
  vim.cmd("stopinsert")
  motion("b")
  vim.cmd("startinsert")
end)
