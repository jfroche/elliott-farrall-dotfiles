{ pkgs
, ...
}:

{
  environment.systemPackages = with pkgs; [
    nix-init
  ];
}
