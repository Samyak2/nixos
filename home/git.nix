{...}: {
  programs.git = {
    enable = true;
    userName = "Samyak S Sarnayak";
    userEmail = "samyak201@gmail.com";

    signing = {
      key = null;
      signByDefault = true;
    };

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
