{ pkgs, ... }:
{
    services = {
        hyprpolkitagent = {
            enable = true;
        };
    };

    environment.systemPackages = with pkgs; [
        hyprpolkitagent  # polkit auth daemon (gui app can request higher ring)
    ];
}
