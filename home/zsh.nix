{pkgs-unstable, ...}: {
  programs.zsh = {
    enable = true;

    # needs `environment.pathsToLink = [ "/share/zsh" ]` in nixos config
    enableCompletion = true;

    initExtraFirst = ''
      function zvm_after_init() {
        zvm_bindkey viins "^R" fzf-history-widget
      }
    '';

    initExtra = ''
      ${pkgs-unstable.nix-your-shell}/bin/nix-your-shell zsh | source /dev/stdin

      # highlight selected options in tab completion
      zstyle ':completion:*' menu select
    '';

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

    plugins = [
      {
        name = "vi-mode";
        src = pkgs-unstable.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];

    # needed for zsh-vi-mode and fzf interop
    # ref: https://github.com/jeffreytse/zsh-vi-mode?tab=readme-ov-file#initialization-mode
    localVariables.ZVM_INIT_MODE = "sourcing";
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = false;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
