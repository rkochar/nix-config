{
  description = "ms1a-nix-config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      system = "x86_64-linux";
    in rec {
      nixosConfigurations."ms1a" = lib.nixosSystem {
	inherit system;
	specialArgs = { inherit inputs; }; # allows access to flake inputs in nixos modules
        modules = [
	  ./ms1a/hardware-configuration.nix
	  ./ms1a/configuration.nix
	  home-manager.nixosModules.home-manager
	  (
	    { pkgs, lib, ... }: {
	      home-manager = {
	        useGlobalPkgs = true; # makes hm use nixos's pkgs value
	        useUserPackages = true;
                extraSpecialArgs = { inherit inputs; }; # allows access to flake inputs in hm modules
                users.rkochar = import ./ms1a/home.nix {
                  inherit pkgs;
                  inherit lib;
	        };
	      };
	    }
	  )
	];
      };
    };
}
