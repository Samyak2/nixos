{pkgs-unstable, ...}: {
  fonts.fontconfig.enable = true;

  home.packages = with pkgs-unstable; [
    victor-mono
  ];
}
