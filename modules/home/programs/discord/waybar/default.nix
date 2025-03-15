{ lib
, config
, ...
}:

let
  cfg = config.programs.discord;
  enable = cfg.enable && config.programs.waybar.enable;
in
{
  config = lib.mkIf enable {
    programs.waybar.settings.mainBar."hyprland/workspaces".window-rewrite = {
      "discord" = "󰙯";
    };
  };
}
