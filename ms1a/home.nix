{ pkgs, lib, ... }:
let 
  values = import ./values.nix;
in rec {
  # TODO: vim and zsh (agnostic)
  imports = [
    ./../modules/user/clitools.nix
    ./../modules/user/flameshot.nix
    ./../modules/user/home-manager.nix
    ./../modules/user/vcs.nix
    ./../modules/user/zsh.nix
    ./../modules/user/vim.nix
  ];

  home = {
    stateVersion = "25.05"; # Please read the comment before changing.
    homeDirectory = "${values.homepath}";
    username = "${values.username}";

    packages = with pkgs; [
      asn
      binutils
      btop
      delta
      dust
      eza
      fastfetchMinimal
      file
      sysz
    ];
  };
}
