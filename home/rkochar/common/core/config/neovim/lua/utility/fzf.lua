local fzf = require("fzf-lua")

fzf.setup({
    keymap = {
        builtin = {
            ["<C-d>"] = "preview-page-down",
            ["<C-u>"] = "preview-page-up",
            ["<C-h>"] = "toggle-help",
            ["<C-p>"] = "toggle-preview",
        },

        fzf = {
            ["ctrl-u"] = "half-page-up",
            ["ctrl-d"] = "half-page-down",
            ["ctrl-a"] = "beginning-of-line",
            ["ctrl-e"] = "end-of-line",
            ["ctrl-f"] = "preview-page-down",
            ["ctrl-b"] = "preview-page-up",
            ["alt-j"] = "down",
            ["alt-k"] = "up",
        },
    },

    files = {
        prompt = "Files> ",
        cwd_prompt = false,
        git_icons = false,
        file_icons = true,
        hidden = true,
        no_ignore = false,
        follow = true,
    },

    grep = {
        prompt = "Grep> ",
        rg_opts = table.concat({
            "--column",
            "--line-number",
            "--no-heading",
            "--color=always",
            "--smart-case",
            "--hidden",
            "--glob=!.git",
            "--glob=!.jj",
        }, " "),
    },

    buffers = {
        prompt = "Buffers> ",
        sort_lastused = true,
    },

    lsp = {
        symbols = {
            symbol_style = 3,
        },
    },
})

local map = vim.keymap.set

local function find_repo_root()
    local dir = vim.uv.cwd()

    while dir and dir ~= "/" do
        if vim.uv.fs_stat(dir .. "/.git") or vim.uv.fs_stat(dir .. "/.jj") then
            return dir
        end

        local parent = vim.fs.dirname(dir)
        if parent == dir then
            break
        end
        dir = parent
    end

    return nil
end

-- adapted from https://github.com/gonstoll/dotfiles/blob/ef33cdd929c53882924f0599597f8aaf8fecbdd9/.config/nvim/lua/utils/fzf.lua#L138
local function folder_grep()
    local repo_root = find_repo_root()
    if not repo_root then
        return nil, "not in a git/jj repo"
    end

    local find_command
    if vim.fn.executable("fd") then
        find_command = "fd . " .. repo_root .. " --type d"
    else
        -- TODO: verify that the find command works
        find_command = "find " .. repo_root .. " -type d"
    end

    fzf.fzf_exec(find_command, {
        prompt = "Folder: ",
        actions = {
            ["default"] = function(selected)
                if selected and #selected > 0 then
                    fzf.live_grep({ cwd = selected[1] })
                end
            end,
        },
    })
end

local function folder_grep_with_file()
    local repo_root = find_repo_root()
    if not repo_root then
        return nil, "not in a git/jj repo"
    end

    local find_command
    if vim.fn.executable("fd") then
        find_command = "fd . " .. repo_root .. " --type f"
    else
        -- TODO: verify that the find command works
        find_command = "find " .. repo_root .. " -type f"
    end

    -- TODO: search in the folder with the file
    fzf.fzf_exec(find_command, {
        prompt = "File: ",
        actions = {
           ["default"] = function(selected)
                if selected and #selected > 0 then
                    fzf.live_grep({ cwd = vim.fs.dirname(selected[1]) })
                end
            end,
        },
    })
end

-- files
map("n", "<leader>ff", fzf.files, { remap = false, desc = "Find files" })
map("n", "<leader>fr", fzf.oldfiles, { remap = false, desc = "Recent files" })

-- grep
map("n", "<leader>fg", fzf.live_grep, { remap = false, desc = "Live grep" })
map("n", "<leader>fw", fzf.grep_cword, { remap = false, desc = "Word grep" })
map("v", "<leader>fg", fzf.grep_visual, { remap = false, desc = "Selection grep" })
map("n", "<leader>fd", function()
    folder_grep()
end, {remap = false, desc = "Live grep in directory"})
map("n", "<leader>fD", function()
    folder_grep_with_file()
end, {remap = false, desc = "Live grep in directory with file"})
map("n", "<leader>fb", fzf.buffers, { remap = false, desc = "Buffers" })

-- lsp
map("n", "gd", fzf.lsp_definitions, { remap = false, desc = "fzf-lsp: Definition" })
map("n", "gr", fzf.lsp_references, { remap = false, desc = "fzf-lsp: References" })
map("n", "gi", fzf.lsp_implementations, { remap = false, desc = "fzf-lsp: Implementations" })
map("n", "<leader>ds", fzf.lsp_document_symbols, { remap = false, desc = "fzf-lsp: Document symbols" })
map("n", "<leader>ws", fzf.lsp_workspace_symbols, { remap = false, desc = "fzf-lsp: Workspace symbols" })

-- diagnostics
map("n", "<leader>fx", fzf.diagnostics_document, { remap = false, desc = "fzf-lsp: Document diagnostics" })
map("n", "<leader>fX", fzf.diagnostics_workspace, { remap = false, desc = "fzf-lsp: Workspace diagnostics" })

-- misc
map("n", "<leader>:", fzf.command_history, { remap = false, desc = "fzf-misc: Command history" })
map("n", "<leader>km", fzf.keymaps, { remap = false, desc = "fzf-misc: Keymaps" })
map("n", "<leader>ht", fzf.help_tags, { remap = false, desc = "fzf-misc: Help tags" })
