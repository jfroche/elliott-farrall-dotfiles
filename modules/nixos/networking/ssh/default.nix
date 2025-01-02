{ ...
}:

{
  services.openssh.enable = true;
  system.activationScripts.setupAuthorizedKeys = ''
    cat /etc/ssh/authorized_keys.d/root >> /root/.ssh/authorized_keys
  '';

  programs.nix-ld.enable = true; # Allows remote connection via vscode
}
