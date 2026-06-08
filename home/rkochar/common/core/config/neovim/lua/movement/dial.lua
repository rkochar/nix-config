local dial_map = require("dial.map")

vim.keymap.set("n", "<c-a>", function()
    dial_map.manipulate("increment", "normal")
end, { remap = false, desc = "increment" })

vim.keymap.set("n", "<c-x>", function()
    dial_map.manipulate("decrement", "normal")
end, { remap = false, desc = "decrement" })

-- vim.keymap.set("n", "g<c-a>", function()
--     dial_map.manipulate("increment", "gnormal")
-- end, { remap = false, desc = "increment" })
--
-- vim.keymap.set("n", "g<c-x>", function()
--     dial_map.manipulate("decrement", "gnormal")
-- end, { remap = false, desc = "decrement" })

vim.keymap.set("x", "<c-a>", function()
    dial_map.manipulate("increment", "visual")
end, { remap = false, desc = "increment" })

vim.keymap.set("x", "<c-x>", function()
    dial_map.manipulate("decrement", "visual")
end, { remap = false, desc = "decrement" })

-- vim.keymap.set("x", "g<c-a>", function()
--     dial_map.manipulate("increment", "gvisual")
-- end, { remap = false, desc = "increment" })
--
-- vim.keymap.set("x", "g<c-x>", function()
--     dial_map.manipulate("decrement", "gvisual")
-- end, { remap = false, desc = "decrement" })

local augend = require("dial.augend")
require("dial.config").augends:register_group{
    default = {
        augend.integer.alias.decimal,
        augend.integer.alias.decimal_int,
        augend.integer.alias.hex,
        augend.integer.alias.octal,
        augend.integer.alias.binary,

        augend.date.alias["%Y/%m/%d"],
        augend.date.alias["%d/%m/%Y"],
        augend.date.alias["%d/%m/%y"],
        augend.date.alias["%Y-%m-%d"],
        augend.date.alias["%d.%m.%Y"],
        augend.date.alias["%d.%m.%y"],
        augend.date.alias["%H:%M:%S"],
        augend.date.alias["%H:%M"],

        -- TODO: whitespace does not seem to be working.
        -- docs seem to have non-printing characters in them
        -- augend.date.alias["%b%-d%-Y"],      -- Jun 05 2025
        -- augend.date.alias["%B%-d%-Y"],      -- June 05 2025
        -- augend.date.alias["%d%-b%-Y"],      -- 05 Jun 2025
        -- augend.date.alias["%d%-B%-Y"],      -- 05 June 2025
        -- augend.date.alias["%b%-d"],        -- Jun 05
        -- augend.date.alias["%B%-d"],        -- June 05
        -- augend.date.alias["%d%-b"],        -- 05 Jun
        -- augend.date.alias["%d%-B"],        -- 05 June
        -- augend.date.alias["%Y-%m-%d %H:%M:%S"],

        augend.constant.alias.alpha,
        augend.constant.alias.Alpha,
        augend.constant.new({elements = {"true", "false"}, word = false, cyclic = true}),
        augend.constant.new({elements = {"True", "False"}, word = false, cyclic = true}),
        augend.constant.new({elements = {"yes", "no"}, word = false, cyclic = true}),
        augend.constant.new({elements = {"Yes", "No"}, word = false, cyclic = true}),
        augend.constant.new({elements = {"on", "off"}, word = false, cyclic = true}),
        augend.constant.new({elements = {"On", "Off"}, word = false, cyclic = true}),
        augend.constant.new({elements = {"&&", "||"}, word = true, cyclic = true}),
        augend.constant.new({elements = {"and", "or"}, word = false, cyclic = true}),

        augend.semver.alias.semver,

        augend.constant.new({elements = {"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"}, word = false, cyclic = true}),
        augend.constant.new({elements = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"}, word = false, cyclic = true}),
        augend.constant.new({elements = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"}, word = false, cyclic = true}),
        augend.constant.new({elements = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"}, word = false, cyclic = true}),
        augend.constant.new({elements = {"first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth"}, word = false, cyclic = true})
    }
}
