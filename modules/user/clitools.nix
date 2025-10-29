{ config, pkgs, ... }:

let
  cfg = config.my.clitools;
in
{
  # options = {
  #   my.clitools = {
  #     shell = lib.mkOption {
  #       type = lib.types.str;
  #       default = "zsh";
  #       description = "Shell";
  #       example = lib.literalExpression "zsh";
  #     };
  #   };
  # };

  programs.bat = {
    enable = true;
  };

  programs.fd = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
  };

  programs.ripgrep = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    # enableZshIntegration = if cfg.shell == "zsh" then true else "false";
    # enableBashIntegration = if cfg.shell == "bash" then true else "false";
  };
}
