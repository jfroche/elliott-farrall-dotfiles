{ config
, lib
, ...
}:

let
  cfg = config.browser;
  enable = cfg == "vivaldi" && config.programs.waybar.enable;
in

{
  config = lib.mkIf enable {
    programs.waybar.settings.mainBar."hyprland/workspaces".window-rewrite = {
      "vivaldi" = "󰖟";
    };
  };
}
