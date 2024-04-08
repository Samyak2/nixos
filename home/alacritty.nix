{
  pkgs-unstable,
  lib,
  ...
}: let
  inherit (pkgs-unstable.stdenv) isDarwin;
in {
  programs.alacritty = {
    enable = true;
    package = pkgs-unstable.alacritty;

    settings = {
      window =
        {
          # background blur
          # opacity = 0.7;
          # blur = true;

          decorations = "None";
          # startup_mode = "Maximized";
        }
        // lib.optionalAttrs isDarwin {
          option_as_alt = "Both";
        };

      font = {
        size = 16;
        normal = {
          family = "VictorMono Nerd Font Mono";
        };
      };
    };
  };
}
