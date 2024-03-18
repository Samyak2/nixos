{pkgs-unstable, ...}: {
  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";

    # taken from:
    # https://github.com/mightyiam/nixconfigs/blob/1fbc481b3b75c5125793a89a9b15a89149d2f974/home/modules/tui/gh.nix#L3
    package = pkgs-unstable.symlinkJoin {
      name = pkgs-unstable.gh.name;
      meta.mainProgram = "gh";
      paths = [pkgs-unstable.gh];
      buildInputs = [pkgs-unstable.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/gh --unset GITHUB_TOKEN
      '';
    };
  };
}
