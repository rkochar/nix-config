{ config, lib, pkgs, ... }:

let
    cfg = config.my.git;
in
{
    options = {
        my.git = {
	    enable = lib.mkEnableOption "Enable git";
	};
    };

    config = lib.mkIf cfg.enable {
	programs.git = {
	    enable = true;
	};
    };
}
