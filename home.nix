{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  nur-hm-modules = inputs.nur.hmModules.nur;
in {
  imports = [
    ./plasma.nix
    nur-hm-modules
  ];

  home.username = "samyak";
  home.homeDirectory = "/home/samyak";

  home.packages = with pkgs; [
    # for signing git commits
    gnupg

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor

    # programming language utils
    alejandra
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

  programs.firefox = {
    enable = true;
    profiles = {
      samyak = {
        id = 0;
        isDefault = true;
        name = "Samyak";

        extensions = [];

        settings = {
          "browser.ctrlTab.recentlyUsedOrder" = true;
          "browser.ctrlTab.sortByRecentlyUsed" = true;
          "general.autoScroll" = true;

          "browser.newtabpage.activity-stream.feeds.snippets" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "browser.newtabpage.activity-stream.feeds.recommendationprovider" = false;
          "browser.newtabpage.activity-stream.discoverystream.sendToPocket.enabled" = false;
          "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
          "extensions.pocket.enabled" = false;

          "app.shield.optoutstudies.enabled" = false;

          "privacy.trackingprotection.enabled" = true;
        };
      };
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
