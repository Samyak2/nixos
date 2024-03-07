{pkgs, ...}: {
  # used by programs.zsh in home-manager
  environment.pathsToLink = ["/share/zsh"];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
}
