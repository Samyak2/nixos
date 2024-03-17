{pkgs, ...}: {
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    # Many applications rely heavily on having an icon theme available, GNOME’s Adwaita is a good choice but most recent icon themes should work as well.
    gnome.adwaita-icon-theme

    # Systray Icons
    gnomeExtensions.appindicator

    # gnome tweak tool
    gnome.gnome-tweaks
  ];

  # Systray Icons
  services.udev.packages = with pkgs; [gnome.gnome-settings-daemon];
}
