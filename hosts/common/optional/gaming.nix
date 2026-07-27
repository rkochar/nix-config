{ config, pkgs, ... }:
{
    # Load nvidia for Wayland and modeset for prime
    services.xserver.videoDrivers = [ "nvidia" "modesetting" ];

    # lspci -nnk | grep -A3 -E "VGA|3D|Display"
    # sudo lshw -c display
    hardware = {
        # Enable OpenGL
        graphics = {
            enable = true;
            # For steam
            enable32Bit = true;
        };

        nvidia = {
            modesetting.enable = true;
            powerManagement = {
                enable = false;
                finegrained = false;
            };

            # Use proprietary
            open = false;

            # nvidia-smi?
            nvidiaSettings = true;

            package = config.boot.kernelPackages.nvidiaPackages.stable;

            prime = {
                offload = {
                    enable = true;
                    enableOffloadCmd = true;
                };
            };
        };
    };

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true; # allows running of game in optimized micro compositor
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # GameMode is a daemon/lib combo for Linux that allows games to request a set
  # of optimisations be temporarily applied to the host OS and/or a game process
  # usage: gamemoderun ./game
  # in steam launch options: gamemoderun %command%
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    protonup-qt
    # lutris
    # heroic
  ];
}
