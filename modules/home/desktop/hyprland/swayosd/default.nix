{ config
, lib
, ...
}:

let
  cfg = config.desktop.hyprland;
  inherit (cfg) enable;
in
{
  config = lib.mkIf enable {
    services.swayosd.enable = true;
  };
}
