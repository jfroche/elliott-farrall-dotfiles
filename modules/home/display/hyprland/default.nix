{ config
, lib
, ...
}:

let
  cfg = config.display;
  enable = cfg.enable && config.wayland.windowManager.hyprland.enable;

  inherit (cfg) output width height refresh scale;
in
{
  config = lib.mkIf enable {
    wayland.windowManager.hyprland.settings.monitor = [
      "${output}, ${toString width}x${toString height}@${toString refresh}, auto, ${toString scale}"
      ", preferred, auto, auto"
    ];
  };
}
