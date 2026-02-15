{
  description = "NixOS configuration";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nixpkgs-stable = {
      url = "github:nixos/nixpkgs/nixos-25.11";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-stable = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, home-manager, home-manager-stable, ... }:
    let
      vars = {
	    user = "rkochar";
      };
    in {
      nixosConfigurations = (
        import ./hosts {
	      inherit (nixpkgs) lib;
	      inherit inputs nixpkgs nixpkgs-stable home-manager vars;
	    }
      );
    };
}
