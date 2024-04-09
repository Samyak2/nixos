# NixOS and home-manager configurations

This repo holds my nix configurations.

## Configurations

- [NixOS](./nixos/default.nix)
- [home-manager](./home/default.nix)
    - Supports both NixOS and MacOS


The [rebuild script](rebuild.sh) takes care of applying the `hardware-configuration.nix` without checking it in to the repo. Also handles formatting nix files and auto-generating a commit message. Inspired by [No Boilerplate's rebuild script](https://gist.github.com/0atman/1a5133b842f929ba4c1e195ee67599d5).

## Flakes

The configurations use nix flakes.

I followed [this guide](https://nixos-and-flakes.thiscute.world/nixos-with-flakes/nixos-with-flakes-enabled) to get NixOS and home-manager running using a flake.

Uses [my neovim config](https://github.com/Samyak2/nvim-config) as an input.

## Hosts

Currently running on these hosts:
- PC with NixOS unstable (also uses home-manager unstable)

## Coming Soon(ish?)

- [x] Configurable home-manager. This will allow me to use this same repo for my Mac's home-manager config as well. The goal is to keep linux-specific and darwin-specific configs separate while sharing as much nix code as possible between them.
- [ ] nix-darwin set up.

## NixOS set up

Starting from a fresh NixOS set up, this describes the steps needed to get a fully working set up.
- Enable flakes support: add the following snippet to `/etc/nixos/configuration.nix`:
  ```nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  ```
- Get `git` and an editor: either add it to `/etc/nixos/configuration.nix` or use `nix-shell -p git neovim`
- Clone this repo: `cd && git clone https://github.com/Samyak2/nixos.git`
- Switch: `sudo nixos-rebuild switch --flake .`
- Reboot
- [Set up ssh and gpg keys](#set-up-ssh-and-gpg-keys)

## MacOS set up

Starting from a fresh Mac OS installation, this describes the steps needed to get a fully working set up.
- Install nix using the [determinate systems installer](https://github.com/DeterminateSystems/nix-installer)
- TODO: xcode CLI tools are needed?
- Clone this repo: `cd && git clone https://github.com/Samyak2/nixos.git`
- Get a shell with `home-manager`: `nix-shell -p home-manager`
- Switch: `home-manager switch --flake .`
- [Set up ssh and gpg keys](#set-up-ssh-and-gpg-keys)

## Set up ssh and gpg keys

- Generate and add a gpg key:
  - `gpg --full-generate-key`
  - `(9) ECC (sign and encrypt) *default*`
  - `(1) Curve 25519 *default*`
  - `Key is valid for? (0) 6m`
  - Use `gpg --list-secret-keys --keyid-format=long` and copy the ID (the text after `ed25519/`)
  - `gpg --armor --export <key-id>`
  - Add gpg key to GitHub: https://github.com/settings/keys
- Generate and add an ssh key:
  - `ssh-keygen -t ed25519 -C "your_email@example.com"`
  - `cat ~/.ssh/id_ed25519.pub` and add it to GitHub: https://github.com/settings/keys
