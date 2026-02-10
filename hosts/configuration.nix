{ lib, config, pkgs, stable, inputs, vars, ... }:

let
in
{
  imports = (
    import ./../modules/vcs
  );

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    rkochar = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [];
    };
  };

  environment.systemPackages = with pkgs; [
    neovim
    wget
    fastfetch
    tree
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  system.stateVersion = "25.11"; # Did you read the comment?
}
