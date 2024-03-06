#!/usr/bin/env bash
set -euxo pipefail

git diff

echo "NixOS Rebuilding..."

cp /etc/nixos/hardware-configuration.nix hardware-configuration.nix

git add .

sudo nixos-rebuild switch --flake .

gen=$(nixos-rebuild list-generations | grep current)

git restore --staged hardware-configuration.nix

git diff --staged

git commit -m "nixos gen: $gen"
git commit --amend