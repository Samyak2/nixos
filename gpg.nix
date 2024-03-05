{...}: {
  programs.gnupg.agent = {
    enable = true;
  };
  services.pcscd.enable = true;
}
