{ config, pkgs, ... }:

let
  values = import ./../values.nix;
in
rec {
  # https://discourse.nixos.org/t/resolvectl-does-not-work-no-service/25912
  # networking.resolvconf.enable = true;
  services.resolved.enable = true;

  # Windscribe does not have a nixpkg. Use wireguard.
  # https://itsfoss.gitlab.io/blog/automatically-connect-to-vpn-on-system-startup-using-systemd/
  # systemctl --user show-environment
  # TODO: system service to user service
  # TODO: apply to some users
  systemd.services.auto-vpn = {
    enable = true;
    restartIfChanged = true;
    reloadIfChanged = true;

    # installConfig
    wantedBy = [ "network-online.target" ];
    
    unitConfig = {
      Description = "Setup Windscribe VPN";
      Requires = [ "network-online.target" "multi-user.target" ];
      StartLimitInterval = 350;
      # ConditionUser = "rkochar";
    };

    serviceConfig = {
      Type = "oneshot";
      # sleep so that the required services are discovered. it is is at least these: "systemd-resolved.service" "dbus-org.freedesktop.resolve1.service" 
      ExecStart = "/run/current-system/sw/bin/sleep 2 ; ${pkgs.wireguard-tools}/bin/wg-quick up ${values.nixconfig}/windscribe.conf";
      ExecStop = "${pkgs.wireguard-tools}/bin/wg-quick down ${values.nixconfig}/windscribe.conf";
      Restart = "on-failure";
      RestartSec = 30;
      RemainAfterExit = "yes";

      # https://wiki.nixos.org/wiki/Systemd/Hardening
      BindReadOnlyPaths = [
        "/nix/store"
      ];
      PrivateDevices = true;
    };
  };
}
