#!/usr/bin/env bash
set -euxo pipefail

to_amend="${1:-}"

git --no-pager diff

echo "home-manage Rebuilding..."

nix flake lock --update-input nvim-config

alejandra . -e hardware-configuration.nix

git add .

home-manager switch --flake .

gen=$(home-manager generations | head -n1 | sed 's/ -> .*$//')

git --no-pager diff --staged

git_commit_extra_args=""
if [[ "$to_amend" == "amend" ]];
then
    git_commit_extra_args="--amend"
fi

git commit $git_commit_extra_args -m "home-manager gen: $gen

$gen"
git commit --amend
