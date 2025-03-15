{ lib
, config
, ...
}:

let
  cfg = config.programs.zotero;
  enable = cfg.enable && config.wayland.windowManager.hyprland.enable;
in
{
  config = lib.mkIf enable {
    wayland.windowManager.hyprland.settings.windowrulev2 = [
      "float, class:(Zotero), title:(Progress)"
    ];
  };
}
