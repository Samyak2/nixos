{
  # config,
  pkgs,
  # lib,
  inputs,
  ...
}: let
  nur-no-pkgs = import inputs.nur {
    pkgs = pkgs;
    nurpkgs = pkgs;
  };
in {
  imports = [
    ./plasma.nix

    {nixpkgs.overlays = [inputs.nur.overlay];}
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

        extensions = with nur-no-pkgs.repos.rycee.firefox-addons; [
          ublock-origin

          bitwarden

          sidebery
        ];

        userChrome = ''
          /* sidebery stuff */
          ${builtins.readFile "${inputs.firefox-csshacks}/chrome/window_control_placeholder_support.css"}
          ${builtins.readFile "${inputs.firefox-csshacks}/chrome/hide_tabs_toolbar.css"}

          /**
           * Decrease size of the sidebar header
           */
          #sidebar-header {
            font-size: 1.2em !important;
            padding: 2px 6px 2px 3px !important;
          }
          #sidebar-header #sidebar-close {
            padding: 3px !important;
          }
          #sidebar-header #sidebar-close .toolbarbutton-icon {
            width: 14px !important;
            height: 14px !important;
            opacity: 0.6 !important;
          }
          /* sidebery stuff end */
        '';

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
