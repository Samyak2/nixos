{email, ...}: {
  programs.git = {
    enable = true;
    userName = "Samyak S Sarnayak";
    userEmail = email;

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
