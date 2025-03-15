{ lib
, config
, ...
}:

let
  cfg = config.browser;
  enable = cfg == "vivaldi" && config.wayland.windowManager.hyprland.enable;
in
{
  config = lib.mkIf enable {
    wayland.windowManager.hyprland.settings.windowrule = [
      "tile, ^(Vivaldi-stable)$"
    ];
  };
}
