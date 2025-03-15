{ lib
, config
, ...
}:

let
  cfg = config.devices.remarkable;
  enable = cfg.enable && config.programs.waybar.enable;
in
{
  config = lib.mkIf enable {
    programs.waybar.settings.mainBar."hyprland/workspaces".window-rewrite = {
      "title<rMview.*>" = "󰐯";
    };
  };
}
