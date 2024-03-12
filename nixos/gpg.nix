{...}: {
  programs.gnupg.agent = {
    enable = true;
    settings = {
      default-cache-ttl = 6 * 60 * 60; # 6 hours
      max-cache-ttl = 6 * 60 * 60; # 6 hours
    };
  };
  services.pcscd.enable = true;
}
