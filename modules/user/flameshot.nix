{ config, pkgs, ... }:

{
  # TODO: hotkey for screenshot. Need to flameshot gui right now.
  services.flameshot = {
    enable = true;
    settings = {
      General = {
        showStartupLaunchMessage = false;
        saveLastRegion = true;
        allowMultipleGuiInstances = false;
        copyOnDoubleClick = true;
        copyPathAfterSave = true;
        uploadHistoryMax = 25;
      };
      Shortcuts = {
        TYPE_CIRCLECOUNT = "i";
        TYPE_IMAGEUPLOADER = "Ctrl+u";
      };
    };  
  };

#   home = {
#     # TODO: for flameshot hotkey
#     https://discourse.nixos.org/t/nixos-options-to-configure-gnome-keyboard-shortcuts/7275/13
#     https://discourse.nixos.org/t/assign-a-hotkey/61131
#     waiting on dconf2nix to add support for dict.
#     dconf.settings = {
#       "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
#         binding = "<Ctrl><Shift>s";
#         command = "exec ${pkgs.flameshot}/bin/flameshot gui";
#         name = "flameshot";
#       };	
#     };
#   };
}
