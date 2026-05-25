{
  inputs,
  lib,
  ...
}:
let
  _stateVersion = "25.11";
in
{
  imports = lib.flatten [
    #
    # ========== Hardware ==========
    #
    ./hardware-configuration.nix

    #
    # ========== Disk Layout ==========
    #
    inputs.disko.nixosModules.disko
    (lib.custom.relativeToRoot "hosts/common/disks/btrfs-disk.nix")
    {
      _module.args = {
        disk = "/dev/disk/by-id/nvme-MSI_M371_1TB_511250813224004843";
        withSwap = true;
	swapSize = 20;
      };
    }

    (map lib.custom.relativeToRoot [
      #
      # ========== Required Configs ==========
      #
      "hosts/common/core"

      #
      # ========== Non-Primary Users to Create ==========
      #
      # FIXME(starter): the primary user, defined in `nix-config/hosts/common/users`, is added by default, via
      # `hosts/common/core` above.
      # To create additional users, specify the path to their config file, as shown in the commented line below, and create/modify
      # the specified file as required. See `nix-config/hosts/common/users/exampleSecondUser` for more info. 

      # Keep out until things are working.
      # "hosts/common/users/tkochar"

      #
      # ========== Optional Configs ==========
      #
      # FIXME(starter): add or remove any optional host-level configuration files the host will use
      # The following are for example sake only and are not necessarily required.
      # openssh should move to core
      "hosts/common/optional/gaming.nix"
      "hosts/common/optional/services/openssh.nix" # allow remote SSH access
      "hosts/common/optional/services/tlp.nix" # laptop power management
      "hosts/common/optional/audio.nix" # pipewire and cli controls
      "hosts/common/optional/gdm.nix"
      "hosts/common/optional/home-manager.nix"
    ])
  ];

  #
  # ========== Host Specification ==========
  #

  hostSpec = {
    hostName = "nitro";
    stateVersion = _stateVersion;
  };

  networking = {
    networkmanager.enable = true;
    enableIPv6 = false;
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  # networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      timeout = 5;
      efi = {
	canTouchEfiVariables = true;
	efiSysMountPoint = "/boot";
      };

      systemd-boot = {
	enable = true;
	configurationLimit = lib.mkDefault 5;

	edk2-uefi-shell = {
	  enable = true;  # Needed to boot into devices in another disk.
          sortKey = "z_edk2";
	};

        extraEntries = {
	  "grub.conf" = ''
          title Original Grub
          efi /efi/edk2-uefi-shell/shell.efi
	  options -nointerrupt -nomap -noversion HD0b:EFI\ubuntu\shimx64.efi
	  sort-key g_grub
          '';
	};

	windows = {
	  "Windows" = {
	    title = "Windows 11";
	    # /EFI/Microsoft/Boot/bootmgfw.efi
	    efiDeviceHandle = "HD0b";  # Find efi with map -c in edk2 shell
	  };
        };
      };
    };

    initrd = {
      systemd = {
	enable = true;
      };
    };
  };

  # Host specific hardware config for gaming
  hardware = {
    nvidia = {
      prime = {
        nvidiaBusId = "PCI:01:00:0";
        amdgpuBusId = "PCI:06:00:0";
       };
    };
    # The replacement driver RADV, part of Mesa, is enabled by default.
    # amdgpu.amdvlk = {
    #   enable = true;
    #   support32Bit.enable = true;
    # };
  };

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  system = {
    stateVersion = _stateVersion; # Did you read the comment?
    autoUpgrade.enable = false;
  };
}
