{
  pkgs-unstable,
  inputs,
  ...
}: {
  imports = [
    # ./plasma.nix
    ./gnome.nix

    {nixpkgs.overlays = [inputs.nur.overlay];}

    ./alacritty.nix
    ./direnv.nix
    ./firefox.nix
    ./git.nix
    ./obs.nix
    ./nvim.nix
    ./zsh.nix
    ./zellij.nix
  ];

  home.username = "samyak";
  home.homeDirectory = "/home/samyak";

  home.packages = with pkgs-unstable; [
    # for signing git commits
    gnupg

    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    bottom # nicer top
    mob # remote mob programming

    # programming language utils
    alejandra # nix formatter

    # video tools
    mkvtoolnix # edit mkv for jellyfin
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
