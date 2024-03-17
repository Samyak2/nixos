{...}: {
  # use `dconf watch /` to track changes in real time
  dconf = {
    enable = true;
    settings = {
      # dark mode
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";

      # no suspend
      "org/gnome/settings-daemon/plugins/power".sleep-inactive-ac-type = "nothing";

      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          "drive-menu@gnome-shell-extensions.gcampax.github.com"
          "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
          "appindicatorsupport@rgcjonas.gmail.com"
        ];
      };

      # disable mouse acceleration
      "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";

      # basic tiling
      "org/gnome/mutter".edge-tiling = true;
      "org/gnome/desktop/interface".enable-hot-corners = false;

      # fonts and display
      "org/gnome/desktop/interface" = {
        font-antialiasing = "rgba";
        font-hinting = "full";

        font-name = "Cantarell 12";
        document-font-name = "Cantarell 12";
        monospace-font-name = "Source Code Pro 11";
      };
      "org/gnome/desktop/wm/preferences".titlebar-font = "Cantarell Bold 12";

      # enable fractional scaling
      # "org/gnome/mutter".experimental-features = ["scale-monitor-framebuffer"];

      # disable fractional scaling and scale text size instead
      "org/gnome/mutter".experimental-features = [];
      "org/gnome/desktop/interface".text-scaling-factor = 1.25;
    };
  };
}
