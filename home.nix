{ config, pkgs, lib, username, ... }:

{
  imports = [
    ./modules/editor.nix
    ./modules/vcs.nix
  ];

  home = {
    username = ${username};
    homeDirectory = "/home/${username}";
    packages = with pkgs; [ ];
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;
}
