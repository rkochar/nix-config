vim.keymap.set("n", "<c-c>", function()
  oil_action.close.callback()
end, { remap = false, desc = "oil: close window" })
