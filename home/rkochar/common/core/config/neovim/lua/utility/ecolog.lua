require('ecolog').setup({
    load_shell = {
        enabled = true,
        override = false,  -- .env takes precedence
    },
    integrations = {
        blink_cmp = true,
        fzf = {
            shelter = {
                mask_on_copy = false, -- Whether to mask values when copying
            },
            mappings = {
                copy_value = "ctrl-y",   -- Copy variable value to clipboard
                copy_name = "ctrl-n",    -- Copy variable name to clipboard
                append_value = "ctrl-a", -- Append value at cursor position
                append_name = "enter",   -- Append name at cursor position
                edit_var = "ctrl-e",     -- Edit environment variable
            },
        },
    },
})
