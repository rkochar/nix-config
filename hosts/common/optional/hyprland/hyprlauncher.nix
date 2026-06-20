# polkit auth daemon (gui app can request higher ring)
# https://wiki.hypr.land/Hypr-Ecosystem/hyprpolkitagent/
{ pkgs, ... }:
{
    services = {
        hyprlauncher = {
            enable = true;
            settings = {
                cache = {
                    enabled = true;
                };
                finders = {
                    desktop_icons = true;
                    math_prefix = "=";
                };
                general = {
                    grab_focus = true;
                };
                ui = {
                    window_size = "400 260";
                };
            };
        };
    };

    environment.systemPackages = with pkgs; [
        hyprlauncher
    ];
}
