{
  pkgs-unstable,
  inputs,
  lib,
  config,
  ...
}: {
  options.local.copilot-enabled = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  config = {
    programs.neovim = {
      enable = true;
      defaultEditor = true;

      extraPackages = with pkgs-unstable;
        [
          gcc # for installing TS grammars

          # language servers
          efm-langserver # generic server for linters, formatters, etc.
          nil # nix language server
          lua-language-server # lua
          nodePackages.pyright # python
          nodePackages.typescript-language-server # js/ts
        ]
        ++ (lib.optionals config.local.copilot-enabled [
          nodejs_21
        ]);
    };

    home.file.".config/nvim".source = "${inputs.nvim-config}";
  };
}
