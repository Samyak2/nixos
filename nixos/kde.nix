{...}: {
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  # This fixes weird cursor in firefox
  programs.dconf.enable = true;

  programs.partition-manager.enable = true;
}
