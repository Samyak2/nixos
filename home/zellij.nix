{pkgs-unstable, ...}: let
  zellij-smart-sessions = pkgs-unstable.fetchurl {
    url = "https://github.com/dj95/zj-smart-sessions/releases/download/v0.3.0/zj-smart-sessions.wasm";
    hash = "sha256-ENG5uEzhV6Y+lE579AipJ1l2nFy6KL1AMtkMvnlV/dw=";
  };
in {
  programs.zellij = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = false;
  };

  xdg.configFile."zellij/config.kdl" = {
    text =
      ''
        plugins {
          zj-smart-sessions location="file:${zellij-smart-sessions}"
        }

      ''
      + (builtins.readFile ../config/zellij/config.kdl);
    recursive = true;
  };
}
