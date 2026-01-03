{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
    let
      lib = inputs.nixpkgs.lib;
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      system = "aarch64-linux";
    in rec {
      nixosConfigurations = {
        wreckerpi = lib.nixosSystem {
	  specialArgs = {
	    inherit inputs;
	  };

          modules = [
            ./configuration.nix
            ./hardware-configuration.nix

            home-manager.nixosModules.home-manager {
              home-manager = {
	        useGlobalPkgs = true;
                useUserPackages = true;
                users.rkochar = ./home.nix;
                # users.wrecker = ./home.nix;

	        extraSpecialArgs = {
		  inherit inputs;
	          username = "rkochar";
	        };
	      };
	    }
          ];
        };
      };
    };
}
