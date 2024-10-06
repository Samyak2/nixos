{
  pkgs-unstable,
  lib,
  config,
  ...
}:
lib.mkIf (!config.local.headless) {
  fonts.fontconfig.enable = true;

  home.packages = with pkgs-unstable; [
    (nerdfonts.override {fonts = ["VictorMono"];})
  ];
}
