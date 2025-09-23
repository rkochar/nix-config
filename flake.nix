{
  description = "ms1a-nix-config";
  inputs = {
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.url = "nixpkgs/nixos-25.05";
  };
  outputs = { self, nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      system = "x86_64-linux";
    in {
      homeConfigurations = {
	ms1a-rkochar = home-manager.lib.homeManagerConfiguration {
	  inherit pkgs;
	  modules = [ ./home.nix ];
	};
      };
      nixosConfigurations = {
        ms1a = lib.nixosSystem {
	  inherit system;
          modules = [ 
	    ./configuration.nix 
	    ./hardware-configuration.nix
	    ];
        };
      };
    };
}
