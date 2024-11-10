{ config
, lib
, ...
}:

let
  cfg = config.terminal;
  enable = cfg == "alacritty" && config.programs.waybar.enable;
in
{
  config = lib.mkIf enable {
    programs.waybar.settings.mainBar."hyprland/workspaces".window-rewrite = {
      "alacritty" = "󰆍";
    };
  };
}
