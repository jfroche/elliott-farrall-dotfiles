{ ...
}:

{
  services.openssh.enable = true;

  programs.nix-ld.enable = true; # Allows remote connection via vscode
}
