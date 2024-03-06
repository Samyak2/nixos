{...}: {
  programs.plasma = {
    enable = true;

    workspace = {
      clickItemTo = "select";
      # tooltipDelay = 5;
      theme = "breeze-dark";
      colorScheme = "BreezeDark";
      # wallpaper = "${pkgs.libsForQt5.plasma-workspace-wallpapers}/share/wallpapers/Kay/contents/images/1080x1920.png";
    };

    # kwin.titlebarButtons = {
    #  left = [ "on-all-desktops" "keep-above-windows" ];
    #  right = [ "help" "minimize" "maximize" "close" ]
    # };

    # spectacle.shortcuts = {
    #   captureActiveWindow = "Meta+Print";
    #   captureCurrentMonitor = "Print";
    #   captureEntireDesktop = "Shift+Print";
    #   captureRectangularRegion = "Meta+Shift+S";
    #   captureWindowUnderCursor = "Meta+Ctrl+Print";
    #   launch = "Meta+S";
    #   launchWithoutCapturing = "Meta+Alt+S";
    # };
  };
}
