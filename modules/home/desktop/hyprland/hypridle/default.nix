{ config
, lib
, ...
}:

let
  cfg = config.desktop.hyprland;
  inherit (cfg) enable;
in
{
  config = lib.mkIf enable {
    services.hypridle.settings = {
      listener = [
        {
          timeout = 500;
          on-timeout = "notify-send 'You are idle!'";
          on-resume = "notify-send 'Welcome back!'";
        }
      ];
    };
  };
}
