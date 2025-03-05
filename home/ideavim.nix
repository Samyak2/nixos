{
  lib,
  config,
  ...
}:
lib.mkIf (config.local.java) {
  xdg.configFile."ideavim" = {
    source = ../config/ideavim;
    recursive = true;
  };
}
