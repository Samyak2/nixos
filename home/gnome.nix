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
    };
  };
}
