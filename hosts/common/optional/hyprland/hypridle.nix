# idle management daemon
# https://wiki.hypr.land/Hypr-Ecosystem/hypridle/

# NOTE: depends on hyprlock
{ pkgs, ... }:
{
    services = {
        hypridle = {
            enable = true;
            settings = {
                general = {
                    after_sleep_cmd = "hyprctl dispatch dpms on";
                    ignore_dbus_inhibit = false;
                    lock_cmd = "hyprlock";
                };
                listener = [
                    {
                        on-timeout = "hyprlock";
                        timeout = 900;
                    }
                    {
                        on-resume = "hyprctl dispatch dpms on";
                        on-timeout = "hyprctl dispatch dpms off";
                        timeout = 1200;
                    }
                ];
            };
        };
    };

    environment.systemPackages = with pkgs; [
        hypridle
        hyprlock
    ];
}
