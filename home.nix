 {config, pkgs, ... }:

 {
    home.username = "samyak";
    home.homeDirectory = "/home/samyak";

    home.packages = with pkgs; [
      # utils
      ripgrep # recursively searches directories for a regex pattern
      jq # A lightweight and flexible command-line JSON processor
    ];

    programs.git = {
      enable = true;
      userName = "Samyak S Sarnayak";
      userEmail = "samyak201@gmail.com";
    };

    programs.firefox = {
      enable = true;
      profiles = {
	samyak = {
	  id = 0;
	  isDefault = true;
	  name = "Samyak";

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

      extraPackages = with pkgs; [ gcc, go ];
    };

    home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink ./nvim-config;

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
