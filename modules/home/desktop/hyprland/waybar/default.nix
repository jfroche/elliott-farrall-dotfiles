{ lib
, config
, ...
}:

let
  cfg = config.desktop.hyprland;
  inherit (cfg) enable;
in
{
  config = lib.mkIf enable {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
    };
  };
}
