{ config, pkgs, ... }:

let 
  values = import ./../values.nix;
in
rec {
  # https://pickard.cc/posts/git-identity-home-manager/
  programs.git = {
    enable = true;

    extraConfig = {
      user = {
        useConfigOnly = true;
        name = "${values.fullname}";
        email = "${values.email}";
      };

      commit = {
	gpgsign = true;
      };

      init = {
	defaultBranch = "master";
      };

      core = {
	pager = "delta";
      };

      interactive = {
	diffFilter = "delta --color-only";
      };

      delta = {
	pager = true;
	# dark = true;  # Should be auto-detected
	side-by-side = true;
	line-numbers = true;
	navigate = true;  # use n and N
      };

      merge = {
	conflictStyle = "zdiff3";
      };
    };
  };

  programs.gpg = {
    enable = true;
  };

  # https://mynixos.com/home-manager/options/services.gpg-agent
  services.gpg-agent = {
    enable = true;
    enableBashIntegration = true;
    enableScDaemon = false;
    enableSshSupport = true;
    verbose = true;
    pinentry.package = pkgs.pinentry-gnome3;
  };

  programs.jujutsu = {
    enable = true;
    ediff = false;

    settings.git = {
      push-new-bookmarks = true;
    };

    settings.user = {
      name = "${values.fullname}";
      email = "${values.email}";
    };

    settings.signing = {
      backend = "gpg";
      behavior = "force";
    };
  };
}
