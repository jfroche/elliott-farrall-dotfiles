{ config
, lib
, ...
}:

let
  cfg = config.editor;
  enable = cfg == "vscode" && config.programs.waybar.enable;
in
{
  config = lib.mkIf enable {
    programs.waybar.settings.mainBar."hyprland/workspaces".window-rewrite = {
      "code" = "󰨞";
    };
  };
}
