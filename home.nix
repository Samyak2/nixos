{
  # config,
  pkgs,
  # lib,
  inputs,
  ...
}: {
  imports = [
    ./plasma.nix

    {nixpkgs.overlays = [inputs.nur.overlay];}

    ./firefox.nix
    ./zsh.nix
    ./zellij.nix
  ];

  home.username = "samyak";
  home.homeDirectory = "/home/samyak";

  home.packages = with pkgs; [
    # for signing git commits
    gnupg

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    bottom # nicer top

    # programming language utils
    alejandra # nix formatter
  ];

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Samyak S Sarnayak";
    userEmail = "samyak201@gmail.com";

    signing = {
      key = null;
      signByDefault = true;
    };

    extraConfig = {
      commit = {
        verbose = true;
      };
      pull = {
        ff = "only";
      };
      push = {
        autoSetupRemote = true;
      };
      init = {
        defaultBranch = "main";
      };
    };

    difftastic = {
      enable = true;
      background = "dark";
      display = "side-by-side-show-both";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      gcc # for installing TS grammars

      # language servers
      efm-langserver
      nil # nix language server
      lua-language-server
    ];
  };

  home.file.".config/nvim".source = "${inputs.nvim-config}";

  programs.alacritty = {
    enable = true;
  };

  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;
    extraConfig = ''
      local wezterm = require 'wezterm'

      local config = wezterm.config_builder()

      config.hide_tab_bar_if_only_one_tab = true

      config.front_end = "Software"

      return config
    '';
  };

  programs.bash = {
    enable = true;
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
