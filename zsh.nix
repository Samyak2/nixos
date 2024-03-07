{...}: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;

    # needs `environment.pathsToLink = [ "/share/zsh" ]` in nixos config
    enableCompletion = true;

    history = {
      extended = true;
      save = 100000;
      size = 100000;
    };

    shellAliases = {
      l = "ls -lh";
      ll = "ls -lah";

      g = "git";
      gst = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git pull";

      gd = "git diff";
      gds = "git diff --staged";
      gs = "git switch";
      gsc = "git switch -c";

      # search for git conflict markers
      conflicts = "rg '[<=>]{7}'";
    };

    syntaxHighlighting = {
      enable = true;
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
