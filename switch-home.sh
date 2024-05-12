#!/usr/bin/env bash
set -euxo pipefail

to_amend="${1:-}"

git --no-pager diff

echo "home-manage Rebuilding..."

nix flake lock --update-input nvim-config

alejandra . -e hardware-configuration.nix

git add .

if [ -x "$(command -v nom)" ]; then
    home-manager switch --flake . |& nom
else
    home-manager switch --flake .
fi

gen=$(home-manager generations | head -n1 | sed 's/ -> .*$//')

git --no-pager diff --staged

if [[ "$to_amend" != "amend" ]];
then
    git commit -m "home-manager gen: $gen

home-manager gen: $gen"
fi

git commit --amend
