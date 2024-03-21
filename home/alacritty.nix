{pkgs-unstable, ...}: {
  programs.alacritty = {
    enable = true;
    package = pkgs-unstable.alacritty;

    settings = {
      window = {
        # background blur
        # opacity = 0.7;
        # blur = true;

        decorations = "None";
        # startup_mode = "Maximized";

        option_as_alt = "Both";
      };

      font = {
        size = 16;
      };
    };
  };
}
