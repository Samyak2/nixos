{
  pkgs-unstable,
  lib,
  config,
  ...
}:
lib.mkIf (config.local.java)
{
  programs.java.enable = true;
  home.packages = with pkgs-unstable; [
    maven
  ];
}
