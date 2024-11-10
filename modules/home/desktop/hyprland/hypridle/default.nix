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
    xdg.configFile."hypr/hypridle.conf".text = ''
      listener {
        timeout = 500                            # in seconds
        on-timeout = notify-send "You are idle!" # command to run when timeout has passed
        on-resume = notify-send "Welcome back!"  # command to run when activity is detected after timeout has fired.
      }
    '';
  };
}
