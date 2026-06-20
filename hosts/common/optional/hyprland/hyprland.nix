{ config, pkgs, ... }:
{
    programs = {
        hyprland = {
            enable = true;
            xwayland.enable = true;
            withUWSM = true;

        };

        uwsm = {
            enable = true;
        };
    };

    environment = {
        # Electron apps should use wayland
        sessionVariables.NIXOS_OZONE_WL = "1";

        systemPackages = with pkgs; [
            kitty  # required (default shell)
            pipewire  # https://wiki.hypr.land/Useful-Utilities/Must-have/#pipewire
            wireplumber  # https://wiki.hypr.land/Useful-Utilities/Must-have/#pipewire

            wayland
            wayland-protocols
            wayland-utils
        ];
    };

    services = {
        xserver = {
            enable = true;
        };

        pipewire = {
            wireplumber.enable = true;
        };
    };
}
