{ pkgs, ... }:

{
  gtk = {
    enable = true;
    iconTheme = {
      name = "elementary-Xfce-dark";
      # FIXME: xfce
      package = pkgs.elementary-xfce-icon-theme;
    };
 };
}
