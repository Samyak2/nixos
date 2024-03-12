{...}: {
  programs.ssh.startAgent = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
}
