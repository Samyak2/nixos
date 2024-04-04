{...}: {
  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  # This fixes weird cursor in firefox
  programs.dconf.enable = true;

  programs.partition-manager.enable = true;
}
