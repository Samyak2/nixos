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

      ./fonts.nix
      ./alacritty.nix
      ./obsidian.nix
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

    fd # nicer find
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

  home.activation = lib.optionalAttrs isDarwin {
    # source: https://github.com/mjrusso/nixos-config/blob/b626e17197d20c68628d7bfe48a1c1911205d9c6/modules/darwin/home-manager.nix

    # Ensure that app launchers (e.g. Alacritty) are properly symlinked (so
    # they can be found via Spotlight, are pinnable to the Dock, etc.).
    #
    # See more discussion here:
    # https://github.com/nix-community/home-manager/issues/1341
    #
    # In particular, this approach is adapted from:
    # https://github.com/nix-community/home-manager/issues/1341#issuecomment-761021848
    #
    # Note that the `readlink` is necessary because because Mac aliases
    # don't work on symlinks, as explained here:
    # https://github.com/NixOS/nix/issues/956#issuecomment-1367457122
    aliasApplications = lib.hm.dag.entryAfter ["writeBoundary"] ''
      app_folder=$(echo /Applications);
      for app in $(find "$newGenPath/home-path/Applications" -type l); do
        $DRY_RUN_CMD rm -f "$app_folder/$(basename $app)"
        $DRY_RUN_CMD /usr/bin/osascript \
            -e "tell app \"Finder\"" \
            -e "make new alias file to POSIX file \"$(readlink $app)\" at POSIX file \"$app_folder\"" \
            -e "set name of result to \"$(basename $app)\"" \
            -e "end tell"
      done
    '';
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
