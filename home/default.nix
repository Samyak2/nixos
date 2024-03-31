{
  pkgs-unstable,
  inputs,
  lib,
  username,
  ...
}: let
  inherit (pkgs-unstable.stdenv) isDarwin;
in {
  imports =
    [
      {nixpkgs.overlays = [inputs.nur.overlay];}

      ./alacritty.nix
      ./direnv.nix
      ./gh.nix
      ./git.nix
      ./nvim.nix
      ./zellij.nix
      ./zsh.nix
    ]
    ++ (
      lib.optionals (!isDarwin) [
        ./plasma.nix
        # ./gnome.nix

        ./obs.nix

        ./firefox.nix
      ]
    );

  home.username = username;
  home.homeDirectory =
    if !isDarwin
    then "/home/${username}"
    else "/Users/${username}";

  home.packages = with pkgs-unstable; [
    # for signing git commits
    gnupg

    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    bottom # nicer top
    mob # remote mob programming
    wl-clipboard # clipboard operations on wayland
    awscli2 # AWS
    devenv # easier development environments using nix
    cachix # binary caches

    # programming language utils
    alejandra # nix formatter
  ];

  programs.bash = {
    enable = true;
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
