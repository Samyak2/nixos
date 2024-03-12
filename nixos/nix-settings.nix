{...}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];
}
