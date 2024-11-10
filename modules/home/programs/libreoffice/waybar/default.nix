{ config
, lib
, ...
}:

let
  cfg = config.programs.libreoffice;
  enable = cfg.enable && config.programs.waybar.enable;
in

{
  config = lib.mkIf enable {
    programs.waybar.settings.mainBar."hyprland/workspaces".window-rewrite = {
      "libreoffice" = "󱇧";
    };
  };
}
