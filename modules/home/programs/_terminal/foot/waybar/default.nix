{ lib
, config
, ...
}:

let
  cfg = config.terminal;
  enable = cfg == "foot" && config.programs.waybar.enable;
in
{
  config = lib.mkIf enable {
    programs.waybar.settings.mainBar."hyprland/workspaces".window-rewrite = {
      "foot" = "󰆍";
      "footclient" = "󰆍";
    };
  };
}
