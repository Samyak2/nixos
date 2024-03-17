{...}: {
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";

      "org/gnome/settings-daemon/plugins/power".sleep-inactive-ac-type = "nothing";

      "org/gnome/shell" = {
        disable-user-extensions = false;

        enabled-extensions = [
          "drive-menu@gnome-shell-extensions.gcampax.github.com"

          "workspace-indicator@gnome-shell-extensions.gcampax.github.com"

          "appindicatorsupport@rgcjonas.gmail.com"
        ];
      };
    };
  };
}
