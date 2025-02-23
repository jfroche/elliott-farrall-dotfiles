{ config
, lib
, pkgs
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
    systemd.services."systemd-notifications-failure@" = {
      description = "Notify when a systemd service fails";

      path = with pkgs; [
        libnotify
        getent
        gawk
        sudo
        dbus
      ];

      script = ''
        for user in $(getent group wheel | awk -F: '{print $4}'); do
          sudo -u $user DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u $user)/bus" notify-send "Service Failed" "$1 has failed."
        done
      '';
      scriptArgs = "%i";

      wantedBy = [ "graphical-session.target" ];
    };

    systemd.packages = [
      (pkgs.runCommandNoCC "systemd-notifications.conf"
        {
          preferLocalBuild = true;
          allowSubstitutes = false;
        } ''
        mkdir -p $out/etc/systemd/system/service.d/
        echo "[Unit]" > $out/etc/systemd/system/service.d/systemd-notifications.conf
        echo "OnFailure=systemd-notifications-failure@%n" >> $out/etc/systemd/system/service.d/systemd-notifications.conf
      '')
    ];
  };
}
