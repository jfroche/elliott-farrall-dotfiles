{ pkgs
, ...
}:

{
  environment.systemPackages = with pkgs; [
    nix-inspect
    nix-melt
  ];
}
