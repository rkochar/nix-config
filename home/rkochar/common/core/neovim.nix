{
  pkgs,
  ...
}:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
    extraLuaConfig = builtins.readFile ./config/vim.lua;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-treesitter-textobjects
      nvim-treesitter.withAllGrammars
      nvim-treesitter-context

      tokyonight-nvim
      material-nvim
      gruvbox-material-nvim
      papercolor-theme-slim
      rainbow-delimiters-nvim
    ];
  };
}
