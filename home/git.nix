{
  email,
  config,
  pkgs-unstable,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "Samyak S Sarnayak";
    userEmail = email;

    # sophos kills perf of nix git for some reason. so use system git while keep config from nix.
    package =
      if config.local.sophos
      then pkgs-unstable.emptyDirectory
      else pkgs-unstable.git;

    signing = {
      key = null;
      signByDefault = true;
    };

    ignores = [
      "/.direnv"
    ];

    extraConfig = {
      commit = {
        verbose = true;
      };
      pull = {
        ff = "only";
      };
      push = {
        autoSetupRemote = true;
      };
      init = {
        defaultBranch = "main";
      };
    };

    difftastic = {
      enable = true;
      background = "dark";
      display = "side-by-side-show-both";
    };
  };
}
