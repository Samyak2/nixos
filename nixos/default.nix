{...}: {
  imports = [
    # Include the results of the hardware scan.
    ../hardware-configuration.nix

    ./boot.nix
    ./networking.nix
    ./time.nix
    ./i18n.nix
    ./x11.nix
    ./printing.nix
    ./input-methods.nix
    ./bluetooth.nix
    ./pipewire.nix
    ./kde.nix
    # ./gnome.nix
    ./fonts.nix
    ./zsh-global.nix
    ./nvim-global.nix
    ./gpg.nix
    ./ssh.nix
    ./nvidia.nix
    ./steam.nix
    ./jellyfin.nix
    ./chromium.nix
    ./mpv.nix

    ./nix-settings.nix

    ./users.nix
    ./system-packages.nix
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
