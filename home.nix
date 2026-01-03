{ config, pkgs, lib, username, ... }:

{
  imports = [
    ./modules/vcs.nix
  ];

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    packages = with pkgs; [ ];
    stateVersion = "25.11";
  };

  my.git.enable = true;

  programs.home-manager.enable = true;
}
