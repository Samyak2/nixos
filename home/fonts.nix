{pkgs-unstable, ...}: {
  fonts.fontconfig.enable = true;

  home.packages = with pkgs-unstable; [
    (nerdfonts.override {fonts = ["VictorMono"];})
  ];
}
