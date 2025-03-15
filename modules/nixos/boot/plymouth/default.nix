{ lib
, pkgs
, config
, ...
}:

let
  inherit (config.catppuccin) flavour;
in
{
  boot.plymouth = {
    enable = true;
    themePackages = lib.mkForce [ (pkgs.catppuccin-plymouth.override { variant = flavour; }) ];
    theme = lib.mkForce "catppuccin-${flavour}";
  };
}
