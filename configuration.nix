# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  networking.hostName = "wrecker"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system for startx.
  # services.xserver = {
  #   enable = true;
  #   displayManager.lightdm.enable = true;
  #   desktopManager.gnome.enable = true;
  #   videoDrivers = [ "fbdev" ];
  # };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    rkochar = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
        tree
      ];
    };

    wrecker = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [
	"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDbOEYUNb2XQmkvG8LkXGWMboH9qn19hEYT4VsS+Or72MdQsjFhM6NmlBlUkAGR0bL8PoGB10VPKTydgT9kuX3OmccDqAbeXBP3HGaLhi6dW2AbLwcLO6FYqPba38rH+A+9YgDwvWlQZ/LwPwMK3N30BIe74RdJf2WCF27M6KE7/dLqBwsY2atoY7eQhqOtzXG3rHRBw+YYUbCh50FNY4BmyVzEs5q3WkXJGBeaIwfGaTJPbM3M51btIBOf8RFPCARBh9nSQyD2hEbmvVgh7PspqkMfjlwqETpSsS66pS4Gmr3FLso82WSXq2gP8bzBLMZZ7zg4e+Zt/M7WL8OaVlHh1G6SSDrkrkMg8wCa44NJhpl9Bevw/v41hphAgdiLi5inDKfGHUdfftudBTXG1ijdzhDAkPRfqNs3k+BIrVNe0TJWQpeLljMjZ+0+El7cmxwcMjLgKy6mN9QsFGXMF5VsR6cwpow+ghiA9yLYWiLzh0omJpE0dycYpEnAvnu3tDtWUgoGCvwu7ZXaLZTFfQcLnxqqDbmbw9LhDX9OcrOXu8Jv8cOAtlF102JOkqYUKiKUmy4lKVwPw62WMpGH6XMtKt2f2nsYKEpfYQigJ/NoCY9StOxIeoVTl18pz7F3E4kUP3osDqGXDg2qjDvMYnTuc/M7/YZzd6WXJI2bS+fL+Q== rkochar@rahul-g5"
      ];
    };
  };

  # programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    libraspberrypi
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    authorizedKeysInHomedir = false;
    settings = {
      PasswordAuthentication = true;
      AllowUsers = [ "wrecker" ];
      PermitRootLogin = "no";
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  system.stateVersion = "25.11"; # Did you read the comment?
}

