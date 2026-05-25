require('nvim-treesitter.configs').setup {
    enable = true,
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
    additional_vim_regex_highlighting = true,
    indent = {
        enable = true;
    },
}

-- https://github.com/nvim-treesitter/nvim-treesitter/tree/main?tab=readme-ov-file#highlighting
vim.api.nvim_create_autocmd('FileType', {
    pattern = { '*' },
    callback = function(args)
        local ok = pcall(vim.treesitter.start(), args.bug)

        if ok then
            -- https://github.com/nvim-treesitter/nvim-treesitter/tree/main?tab=readme-ov-file#indentation
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    end,
})

vim.opt.foldcolumn = "auto"
-- vim.opt.foldcolumn = "auto:[1-3]"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldminlines = 1
vim.opt.foldenable = true  -- see zi (map)
vim.opt.foldmethod = 'expr'

-- TODO: (inverse) fold on match
-- " https://stackoverflow.com/a/58514774/12555857
-- nnoremap <leader>F :setlocal foldexpr=(getline(v:lnum)=~@/)?0:1 foldmethod=expr foldlevel=0 foldcolumn=2 foldminlines=0<CR><CR>
-- nnoremap <leader>f :setlocal foldexpr=(getline(v:lnum)=~@/)?1:0 foldmethod=expr foldlevel=0 foldcolumn=2 foldminlines=0<CR><CR>

-- https://github.com/nvim-treesitter/nvim-treesitter/tree/main?tab=readme-ov-file#folds
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
-- https://www.reddit.com/r/neovim/comments/16xz3q9/treesitter_highlighted_folds_are_now_in_neovim/
vim.opt.foldtext = require('treesitter.foldtext')
