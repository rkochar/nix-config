{ inputs, pkgs, ... }:

{
  environment.systemPackages = [
    inputs.vortex.packages.${pkgs.system}.vortex
  ];
}
