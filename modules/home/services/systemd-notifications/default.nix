{ lib
, pkgs
, config
, ...
}:

let
  cfg = config.services.systemd-notifications;
  inherit (cfg) enable;
in
{
  options = {
    services.systemd-notifications.enable = lib.mkEnableOption "notifications for systemd services" // { default = true; };
  };

  config = lib.mkIf enable {
    systemd.user.services."systemd-notifications-failure@" = {
      Unit = {
        Description = "Notify when a systemd service fails";
      };
      Service = {
        ExecStart = "${pkgs.libnotify}/bin/notify-send 'Service Failed' '%i has failed.'";
      };
    };

    xdg.configFile."systemd/user/service.d/systemd-notifications.conf".text = ''
      [Unit]
      OnFailure=systemd-notifications-failure@%n
    '';
  };
}
