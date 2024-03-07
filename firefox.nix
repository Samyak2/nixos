{
  pkgs,
  inputs,
  ...
}: let
  nur-no-pkgs = import inputs.nur {
    inherit pkgs;
    nurpkgs = pkgs;
  };
in {
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
          # enable userChrome.css
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

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
}
