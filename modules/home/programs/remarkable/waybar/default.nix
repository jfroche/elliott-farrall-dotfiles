{ config
, lib
, ...
}:

let
  cfg = config.programs.remarkable;
  enable = cfg.enable && config.programs.waybar.enable;
in
{
  config = lib.mkIf enable {
    programs.waybar.settings.mainBar."hyprland/workspaces".window-rewrite = {
      "rmview" = "󰐯";
    };
  };
}
