{...}: {
  home.file.".npmrc".text = ''
    prefix = ''${HOME}/.npm-packages
  '';

  home.sessionPath = ["$HOME/.npm-packages/bin/"];
}
