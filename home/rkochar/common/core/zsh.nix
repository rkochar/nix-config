{
  pkgs,
  ...
}:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;  # https://github.com/rkochar/zsh-vim-mode?tab=readme-ov-file#installation  # order plugins to avoid conflict but https://github.com/zsh-users/zsh-syntax-highlighting?tab=readme-ov-file#why-must-zsh-syntax-highlightingzsh-be-sourced-at-the-end-of-the-zshrc-file
    history.size = 10000;

    shellAliases = {
    };

    initContent = builtins.readFile ./config/zshrc;

    plugins = [
      {
  	name = "zsh-autosuggestions";
	src = pkgs.fetchFromGitHub {
	  owner = "zsh-users";
	  repo = "zsh-autosuggestions";
	  rev = "v0.7.1";
	  sha256 = "vpTyYq9ZgfgdDsWzjxVAE7FZH4MALMNZIFyEOBLm5Qo=";
	};
      }
      {
          name = "vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
      {
  	name = "zsh-async";
	file = "async.zsh";
	src = pkgs.fetchFromGitHub {
	  owner = "mafredri";
	  repo = "zsh-async";
	  rev = "v1.8.6";
	  sha256 = "sha256-Js/9vGGAEqcPmQSsumzLfkfwljaFWHJ9sMWOgWDi0NI=";
	};
      }
      {
        name = "powerlevel10k";
	src = pkgs.zsh-powerlevel10k;
	file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
  };
}
