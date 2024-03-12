{...}: {
  programs.plasma = {
    enable = true;

    workspace = {
      clickItemTo = "select";
      # tooltipDelay = 5;
      theme = "breeze-dark";
      colorScheme = "BreezeDark";
    };

    spectacle.shortcuts = {
      captureRectangularRegion = "Print";
      captureActiveWindow = "Ctrl+Print";
      captureCurrentMonitor = "Shift+Print";
      captureEntireDesktop = "Ctrl+Shift+Print";
      launch = "Meta+S";
    };
  };
}
