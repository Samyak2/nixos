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

      extraLuaConfig = ''
        SET_UP_THROUGH_MY_NIX_HM_CONFIG=true
      '';

      extraPackages = with pkgs-unstable; [
        gcc # for installing TS grammars

        # language servers
        efm-langserver # generic server for linters, formatters, etc.
        nil # nix language server
        lua-language-server # lua
        # basedpyright # python
        nodePackages.typescript-language-server # js/ts
        # the below provides eslint, html, css, json, md
        vscode-langservers-extracted
        taplo # TOML toolkit

        # required for iamcco/markdown-preview.nvim and copilot
        nodejs_22
      ];
    };

    home.file.".config/nvim".source = "${inputs.nvim-config}";

    # iamcco/markdown-preview.nvim wants to build a typescript package on the first run.
    # we instead include the pre-built node_modules available from nixpkgs.
    home.file.".local/share/nvim/lazy/markdown-preview.nvim/app/node_modules".source = config.lib.file.mkOutOfStoreSymlink "${pkgs-unstable.vimPlugins.markdown-preview-nvim}/app/node_modules";
  };
}
