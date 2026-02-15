{ config, pkgs, ... }:

let
  cfg = config.my.clitools;
in
{
  programs.bat = {
    enable = true;
  };

  programs.fzf = {
    keybindings = true;
    fuzzyCompletion = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
