{
  email,
  config,
  pkgs-unstable,
  ...
}: {
  programs.git = {
    enable = true;

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

    settings = {
      user = {
        email = email;
        name = "Samyak S Sarnayak";
      };
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
  };

  programs.difftastic = {
    enable = true;

    git.enable = true;

    options = {
      background = "dark";
      display = "side-by-side-show-both";
    };
  };
}
