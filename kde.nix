{...}: {
  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # This fixes weird cursor in firefox
  programs.dconf.enable = true;
}
