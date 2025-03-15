{ lib
, pkgs
, config
, ...
}:

let
  cfg = config.desktop.hyprland;
  inherit (cfg) enable;
in
{
  config = lib.mkIf enable {
    services.hypridle = {
      enable = true;
      settings.listener = [
        {
          timeout = 500;
          on-timeout = "${pkgs.libnotify}/bin/notify-send 'You are idle!'";
          on-resume = "${pkgs.libnotify}/bin/notify-send 'Welcome back!'";
        }
      ];
    };
  };
}
