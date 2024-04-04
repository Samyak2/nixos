#!/usr/bin/env bash
to_amend="$1"

set -euxo pipefail

git --no-pager diff

echo "NixOS Rebuilding..."

cp /etc/nixos/hardware-configuration.nix hardware-configuration.nix

nix flake lock --update-input nvim-config

alejandra . -e hardware-configuration.nix

git add .

sudo nixos-rebuild switch --flake .

gen=$(nixos-rebuild list-generations | grep current)

gen_only=$(echo $gen | cut -d " " -f 1)

git restore --staged hardware-configuration.nix

git --no-pager diff --staged

git_commit_extra_args=""
if [[ "$to_amend" == "amend" ]];
then
    git_commit_extra_args="--amend"
fi

git commit $git_commit_extra_args -m "nixos gen: $gen_only

nixos gen: $gen"
git commit --amend
