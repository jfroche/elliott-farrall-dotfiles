{ config
, lib
, ...
}:

let
  cfg = config.programs.mathematica;
  enable = cfg.enable && config.wayland.windowManager.hyprland.enable;
in
{
  config = lib.mkIf enable {
    wayland.windowManager.hyprland.settings.windowrule = [
      "float, title:^(Mathematica)$"
    ];
  };
}
