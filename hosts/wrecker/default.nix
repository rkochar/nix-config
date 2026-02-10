{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
      grub.enable = false;
      # Enables the generation of /boot/extlinux/extlinux.conf
      generic-extlinux-compatible.enable = true;
      timeout = 5;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      libraspberrypi
    ];
  };

  programs = {
    firefox.enable = false;
  };

  # Enable the X11 windowing system for startx.
  # services.xserver = {
  #   enable = true;
  #   displayManager.lightdm.enable = true;
  #   desktopManager.gnome.enable = true;
  #   videoDrivers = [ "fbdev" ];
  # };

  networking = {
    hostName = "wrecker"; # Define your hostname.

    # Configure network connections interactively with nmcli or nmtui.
    networkmanager.enable = true;

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    firewall.enable = false;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

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

  users.users = {
    wrecker = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      packages = with pkgs; [];
      openssh.authorizedKeys.keys = [
	"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDbOEYUNb2XQmkvG8LkXGWMboH9qn19hEYT4VsS+Or72MdQsjFhM6NmlBlUkAGR0bL8PoGB10VPKTydgT9kuX3OmccDqAbeXBP3HGaLhi6dW2AbLwcLO6FYqPba38rH+A+9YgDwvWlQZ/LwPwMK3N30BIe74RdJf2WCF27M6KE7/dLqBwsY2atoY7eQhqOtzXG3rHRBw+YYUbCh50FNY4BmyVzEs5q3WkXJGBeaIwfGaTJPbM3M51btIBOf8RFPCARBh9nSQyD2hEbmvVgh7PspqkMfjlwqETpSsS66pS4Gmr3FLso82WSXq2gP8bzBLMZZ7zg4e+Zt/M7WL8OaVlHh1G6SSDrkrkMg8wCa44NJhpl9Bevw/v41hphAgdiLi5inDKfGHUdfftudBTXG1ijdzhDAkPRfqNs3k+BIrVNe0TJWQpeLljMjZ+0+El7cmxwcMjLgKy6mN9QsFGXMF5VsR6cwpow+ghiA9yLYWiLzh0omJpE0dycYpEnAvnu3tDtWUgoGCvwu7ZXaLZTFfQcLnxqqDbmbw9LhDX9OcrOXu8Jv8cOAtlF102JOkqYUKiKUmy4lKVwPw62WMpGH6XMtKt2f2nsYKEpfYQigJ/NoCY9StOxIeoVTl18pz7F3E4kUP3osDqGXDg2qjDvMYnTuc/M7/YZzd6WXJI2bS+fL+Q== rkochar@rahul-g5"
      ];
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = false;

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # List services that you want to enable:
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
}
