{ config, pkgs, ... }:

{
  home = {
    username = "wrecker";
    homeDirectory = "/home/wrecker";
    packages = [ ];
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;
}
