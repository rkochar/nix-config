{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-treesitter-parsers.nix
      papercolor-theme-slim
    ];
    extraLuaConfig = ''
      vim.opt.number = true
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.smartindent = true
      vim.cmd('colorscheme PaperColorSlim')
    '';
  };
}
