local notify = require("notify")

notify.setup({
    level = vim.log.levels.INFO,
    timeout = 1000,
    stages = "fade_in_slide_out",
    render = "compact",
})

vim.keymap.set("n", "<leader>nd", function()
    notify.dismiss({ silent = true, pending = false })
end, { desc = "Dismiss all notifications", remap = false})

vim.keymap.set("n", "<leader>nD", function()
    notify.dismiss({ silent = true, pending = true })
end, { desc = "Dismiss all notifications (+ queued)", remap = false})

vim.notify = notify
