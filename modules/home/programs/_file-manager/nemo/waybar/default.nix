{ lib
, config
, ...
}:

let
  cfg = config.file-manager;
  enable = cfg == "nemo" && config.programs.waybar.enable;
in
{
  config = lib.mkIf enable {
    programs.waybar.settings.mainBar."hyprland/workspaces".window-rewrite = {
      "nemo" = "󰪶";
    };
  };
}
