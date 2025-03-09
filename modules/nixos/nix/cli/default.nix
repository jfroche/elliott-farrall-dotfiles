{ pkgs
, ...
}:

{
  environment.systemPackages = with pkgs; [
    snowfallorg.flake
    nix-output-monitor
    nix-fast-build
  ];
}
