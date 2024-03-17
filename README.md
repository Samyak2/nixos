# NixOS and home-manager configurations

This repo holds my nix configurations.

## Configurations

- [NixOS](./nixos/default.nix)
- [home-manager](./home/default.nix)
    - This is currently very specific to the above NixOS config and only made for Linux


The [rebuild script](rebuild.sh) takes care of applying the `hardware-configuration.nix` without checking it in to the repo. Also handles formatting nix files and auto-generating a commit message. Inspired by [No Boilerplate's rebuild script](https://gist.github.com/0atman/1a5133b842f929ba4c1e195ee67599d5).

## Flakes

The configurations use nix flakes.

I followed [this guide](https://nixos-and-flakes.thiscute.world/nixos-with-flakes/nixos-with-flakes-enabled) to get nixos and home-manager running using a flake.

Uses [my neovim config](https://github.com/Samyak2/nvim-config) as an input.

## Hosts

Currently running on these hosts:
- PC with NixOS unstable (also uses home-manager unstable)

## Coming Soon(ish?)

- [ ] Configurable home-manager. This will allow me to use this same repo for my Mac's home-manager config as well. The goal is to keep linux-specific and darwin-specific configs separate while sharing as much nix code as possible between them.
- [ ] nix-darwin set up.
