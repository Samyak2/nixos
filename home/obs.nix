{
  lib,
  config,
  ...
}:
lib.mkIf (!config.local.headless)
{
  programs.obs-studio.enable = true;
}
