require("lsp/blink")
require("lsp/nix")
require("lsp/bazel")
require("lsp/go")
require("lsp/python")

-- vim.api.nvim_create_autocmd("LspAttach", {
--     callback = function(args)
--         local bufnr = args.buf
--
--         if vim.b[bufnr].lsp_signature_attached then
--             return
--         end
--
--         vim.b[bufnr].lsp_signature_attached = true
--         require("lsp_signature").on_attach({}, bufnr)
--     end,
-- })
