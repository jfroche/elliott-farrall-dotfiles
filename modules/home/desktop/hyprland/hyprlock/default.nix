{ lib
, config
, ...
}:

let
  cfg = config.desktop.hyprland;
  inherit (cfg) enable;
in
{
  config = lib.mkIf enable {
    stylix.targets.hyprlock.useWallpaper = false;
  };
}
