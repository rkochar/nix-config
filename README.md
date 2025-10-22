# Nix Config

```sh
ln -s ~/nix-config/configuration.nix /etc/nixos/configuration.nix
ln -s ~/nix-config/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
ln -s ~/nix-config/home.nix ~/.config/home-manager/home.nix

ln -s ~/nix-config/p10k.zsh ~/.p10k.zsh  # TODO: don't symlink. [can help](https://discourse.nixos.org/t/configuring-powerleve10k-with-nixos-flakes-and-home-manager/41984).

# TODO: fzf expects these scripts at this specific location. `~` takes away part of the absolute path but it is still hanging and easy to break.
chmod +x ~/nix-config/fzf-preview.bash
```

## Resources
[LibrePhoenix guide for nix](https://librephoenix.com/2023-10-08-why-you-should-use-nixos.html)

[Using git](https://dev.to/raymondgh/day-5-syncing-nix-config-across-laptop-and-desktop-1i41)
