{pkgs, ...}: {
  # i use home-manager, so no packages required here

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    #  git

    nix-output-monitor # better nix output
    nvd # nix diff
  ];
}
