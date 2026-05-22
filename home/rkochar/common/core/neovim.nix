{
  pkgs,
  ...
}:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
    extraLuaConfig = ''
      vim.opt.number = true
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.smartindent = true
    '';
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-treesitter.withAllGrammars

      rainbow-delimiters-nvim      
    ];
  };
}
