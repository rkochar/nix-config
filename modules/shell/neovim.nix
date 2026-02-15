{ config, lib, system, pkgs, stable, vars, ...}:

let
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    configure = {
      customLuaRC = ''
        ${builtins.readFile ./init.lua}
      '';
      packages.myVimPackage = with pkgs.vimPlugins; {
	start = [
	  nvim-lspconfig
          nvim-treesitter-parsers.nix
          papercolor-theme-slim
	];
      };
    };
  };
}
