# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

let 
  values = import ./values.nix;
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../modules/system/audio.nix
      ./../modules/system/bluetooth.nix
      ./../modules/system/location.nix
      ./../modules/system/vpn.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Zen kernel https://nixos.wiki/wiki/Linux_kernel
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;

  networking.hostName = "ms1a";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # TODO: module
  users = {
    users.${values.username} = {
      ignoreShellProgramCheck = false;
      isNormalUser = true;
      description = "${values.fullname}";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
        keepassxc  # TODO: gnome has a built-in. needed?
        tradingview
      ];
      shell = pkgs.zsh;  # https://nixos.wiki/wiki/Command_Shell
    };
  };

  # Install firefox.
  # TODO: what does rgb need?
  programs.firefox.enable = true;

  programs.zsh.enable = true;
  fonts.packages = with pkgs; [ meslo-lgs-nf ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    wireguard-tools
  ];

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system = {
    stateVersion = "25.05"; # Did you read the comment?
    autoUpgrade.enable = false;
  };
}
