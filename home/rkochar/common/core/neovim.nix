{
  config,
  pkgs,
  home,
  ...
}:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
    extraLuaConfig = builtins.readFile ./config/neovim/init.lua;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-treesitter-textobjects
      nvim-treesitter.withAllGrammars
      nvim-treesitter-context

      tokyonight-nvim
      material-nvim
      gruvbox-material-nvim
      papercolor-theme-slim
      onedark-nvim
      rainbow-delimiters-nvim
    ];
  };

  home.file.".config/nvim/lua".source = ./config/neovim/lua;
}
