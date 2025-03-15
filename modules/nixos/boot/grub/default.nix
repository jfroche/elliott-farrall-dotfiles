{ lib
, pkgs
, config
, ...
}:

let
  cfg = config.boot.loader.grub;
  inherit (cfg) enable;

  inherit (config.catppuccin) flavour;
in

{
  config = lib.mkIf enable {
    boot.loader.grub.theme = lib.mkForce "${pkgs.catppuccin-grub.override { flavor = flavour;}}";
  };
}
