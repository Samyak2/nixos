{
  pkgs-unstable,
  inputs,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs-unstable; [
      gcc # for installing TS grammars

      # language servers
      efm-langserver
      nil # nix language server
      lua-language-server
    ];
  };

  home.file.".config/nvim".source = "${inputs.nvim-config}";
}
