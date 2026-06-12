vim.lsp.config("basedpyright", {
  cmd = { "basedpyright-langserver", "--stdio" },

  filetypes = { "python" },

  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "pyrightconfig.json",
  },

  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "standard", -- "basic" | "standard" | "strict"
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly", -- or "openFilesOnly"
      },
    },
  },
})

vim.lsp.enable("basedpyright")
