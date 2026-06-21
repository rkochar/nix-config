-- https://github.com/nvim-treesitter/nvim-treesitter/issues/2108#issuecomment-995069984
function does_treesitter_parser_exist()
    return pcall(vim.treesitter.get_parser, buf)
end

-- https://github.com/nvim-treesitter/nvim-treesitter/tree/main?tab=readme-ov-file#highlighting
vim.api.nvim_create_autocmd('FileType', {
    pattern = { '*' },
    callback = function(args)
        local file = vim.api.nvim_buf_get_name(args.buf)
        local ok, stats = pcall(vim.loop.fs_stat, file)
        local max_filesize = 100*1024

        if ok and stats and stats.size > max_filesize then
            return
        end

        pcall(vim.treesitter.start, args.buf)
        if does_treesitter_parser_exist() then
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


-- Standard neovim config --
vim.opt.smartindent = false  -- let treesitter figure out indents
vim.opt.autoindent = false   -- let treesitter figure out indents

-- :h gq for formatting with movements
vim.keymap.set('n', '<leader>i', 'gg=G', {desc = 'Indent file', remap = false})
