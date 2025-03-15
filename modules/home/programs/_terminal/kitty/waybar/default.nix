{ lib
, config
, ...
}:

let
  cfg = config.terminal;
  enable = cfg == "kitty" && config.programs.waybar.enable;
in
{
  config = lib.mkIf enable {
    programs.waybar.settings.mainBar."hyprland/workspaces".window-rewrite = {
      "kitty" = "󰆍";
    };
  };
}
