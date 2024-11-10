{ config
, lib
, ...
}:

let
  cfg = config.browser;
  enable = cfg == "firefox" && config.programs.waybar.enable;
in

{
  config = lib.mkIf enable {
    programs.waybar.settings.mainBar."hyprland/workspaces".window-rewrite = {
      "firefox" = "󰈹";
    };
  };
}
