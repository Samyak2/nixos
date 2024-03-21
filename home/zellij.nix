{...}: {
  programs.zellij = {
    enable = true;
  };

  xdg.configFile."zellij" = {
    source = ../config/zellij;
    recursive = true;
  };
}
