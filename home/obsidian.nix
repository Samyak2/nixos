{
  pkgs-unstable,
  lib,
  config,
  ...
}:
lib.mkIf (!config.local.headless)
{
  home.packages = with pkgs-unstable; [
    obsidian
  ];
}
