{ config, pkgs, ... }:

{
  # https://nixos.wiki/wiki/Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings = {
      General = {
        Experimental = true;
	FastConnectable = false;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };
  services.blueman.enable = true;
}
