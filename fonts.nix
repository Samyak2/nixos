{pkgs, ...}: {
  fonts = {
    packages = [pkgs.overpass];
    fontDir.enable = true;

    fontconfig = {
      defaultFonts = {
        monospace = ["Overpass"];
      };
    };
  };
}
