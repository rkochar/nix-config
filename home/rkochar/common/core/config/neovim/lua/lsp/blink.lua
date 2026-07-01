local function accept_index(index)
    return function(cmp)
        cmp.accept({ index = index })
    end
end

require("blink.cmp").setup({
    enabled = function() return not vim.tbl_contains({ "markdown" }, vim.bo.filetype) end,
    cmdline = {
        enabled = true,
        keymap = { preset = 'inherit' },
        completion = {
            menu = { auto_show = true },
            list = {
                selection = {
                    preselect = false,
                    auto_insert = false,
                },
            },
            ghost_text = { enabled = true },
        },
    },
    term = { enabled = true },

    keymap = {
        -- preset = 'default',
        ['<c-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<c-c>'] = { 'hide', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },
        ['<c-y>'] = { 'select_and_accept', 'fallback' },
        ["<c-g>"] = {  -- ripgrep
            function()
                require("blink-cmp").show({ providers = { "ripgrep" } })
            end,
        },

        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<c-p>'] = { 'select_prev', 'fallback_to_mappings' },
        ['<c-n>'] = { 'select_next', 'fallback_to_mappings' },

        ['<c-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<c-f>'] = { 'scroll_documentation_down', 'fallback' },

        -- TODO: snippets, supertab
        ['<Tab>'] = {
            -- function(cmp)
            --     if cmp.snippet_active() then return cmp.accept()
            --     else return cmp.select_and_accept() end
            -- end,
            'snippet_forward',
            'fallback'
        },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

        ['<c-k>'] = { 'show_signature', 'hide_signature', 'fallback' },

        -- https://cmp.saghen.dev/recipes.html#select-nth-item-from-the-list
        ['<A-1>'] = { accept_index(1) },
        ['<A-2>'] = { accept_index(2) },
        ['<A-3>'] = { accept_index(3) },
        ['<A-4>'] = { accept_index(4) },
        ['<A-5>'] = { accept_index(5) },
        ['<A-6>'] = { accept_index(6) },
        ['<A-7>'] = { accept_index(7) },
        ['<A-8>'] = { accept_index(8) },
        ['<A-9>'] = { accept_index(9) },
        ['<A-0>'] = { accept_index(10) },
    },

    -- snippets = { preset = 'default' | 'luasnip' | 'mini_snippets' | 'vsnip' },
    sources = {
        -- TODO: add snippets
        default = { "ecolog", "lsp", "path", "buffer", "ripgrep", "nerdfont" },

        per_filetype = {},  -- custom

        providers = {
            ripgrep = {
                module = "blink-ripgrep",
                name = "Ripgrep",
                opts = {
                    prefix_min_len = 3,
                    context_size = 5,
                    project_root_marker = { ".jj", ".git" },  -- TODO: global config?
                    fallback_to_regex_highlighting = true,
                    backend = {
                        use = "gitgrep-or-ripgrep",  -- gitgrep is faster. fallback on ripgrep
                        customize_icon_highlight = true,
                        ripgrep = {
                            context_size = 5,
                            max_filesize = "1M",
                            project_root_fallback = true,
                            search_casing = "--ignore-case",
                            additional_rg_options = {},
                            ignore_paths = {},
                            additional_paths = {},
                        },
                        gitgrep = {
                            additional_gitgrep_options = {},
                        },
                    },
                },
            },
            nerdfont = {
                module = "blink-nerdfont",
                name = "NerdFont",
                opts = { -- TODO: check config
                    insert = true,
                    trigger = ":",
                },
            },
            ecolog = {
                name = 'ecolog',
                module = 'ecolog.integrations.cmp.blink_cmp',
            },
        },
    },

    -- TODO: add native signature: https://cmp.saghen.dev/configuration/signature.html
    signature = { enabled = false },

    completion = {
        keyword = { range = 'full' },  -- or 'prefix'
        accept = {
            auto_brackets = {
                enabled = true, -- lsp can overwrite
                default_brackets = { '(', ')' },  -- for unknown languages
                override_brackets_for_filetypes = {},
                kind_resolution = {
                    enabled = true,
                    blocked_filetypes = {},
                },
                -- Asynchronously use semantic token to determine if brackets should be added
                semantic_token_resolution = {
                    enabled = true,
                    blocked_filetypes = {},
                    -- How long to wait for semantic tokens to return before assuming no brackets should be added
                    timeout_ms = 400,
                },
            },
        },

        trigger = {
            show_on_trigger_character = true,
            show_on_blocked_trigger_characters = { ' ', '\n', '\t' },
            show_on_insert_on_trigger_character = true,
            show_on_x_blocked_trigger_characters = {
                "'", '"', '(', '{', '['
            },
            show_on_accept_on_trigger_character = true,
            show_on_x_blocked_trigger_characters = { "'", '"', '(', '{', '[' },
            show_in_snippet = false,  -- https://cmp.saghen.dev/configuration/keymap.html#super-tab
        },

        list = {
            selection = {
                preselect = true,
                auto_insert = true,
            },
        },

        menu = {
            enabled = true,
            scrollbar = true,
            auto_show = true,  -- maybe conflicts with ghost_text`

            draw = {
                treesitter = { 'lsp' },

                columns = {
                    { 'item_idx' },
                    { "kind_icon" },
                    { 
                        "label",
                        "label_description",
                        gap = 1
                    }
                },
                components = {
                    label = {
                        text = function(ctx)
                            return require("colorful-menu").blink_components_text(ctx)
                        end,
                        highlight = function(ctx)
                            return require("colorful-menu").blink_components_highlight(ctx)
                        end,
                    },
                    item_idx = {
                        text = function(ctx) return ctx.idx == 10 and '0' or ctx.idx >= 10 and ' ' or tostring(ctx.idx) end,
                        highlight = 'BlinkCmpItemIdx' -- optional, only if you want to change its color
                    }
                },
            },
        },

        documentation = {
            auto_show = false,
            auto_show_delay_ms = 500,
            update_delay_ms = 50,
            treesitter_highlighting = true,
        },

        ghost_text = {
            enabled = true,  -- maybe menu.auto_show conflicts
            show_with_selection = true,
            show_without_selection = false,
            show_with_menu = true,
            show_without_menu = true,
        },
    },

    fuzzy = {
        implementation = "prefer_rust_with_warning",
        sorts = {
            'exact',      -- https://cmp.saghen.dev/recipes#always-prioritize-exact-matches
            'score',      -- Primary sort: by fuzzy matching score
            'sort_text',  -- Secondary sort: by sortText field if scores are equal
            'label',      -- Tertiary sort: by label if still tied
        },
        max_typos = function(keyword) return math.floor(#keyword / 4) end,  -- 0 matches fzf
        frecency = {
            enabled = true,
            unsafe_no_lock = false,
            path = vim.fn.stdpath('state') .. '/blink/cmp/frecency.dat',
        },
        use_proximity = true,
        prebuilt_binaries = {
            download = true,
            ignore_version_mismatch = false,
            -- proxy = { url = nil },
        },
    },
})
