{ pkgs
, ...
}:

{
  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nix-fast-build
  ];
}
