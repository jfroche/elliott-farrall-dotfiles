{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.locker;
  enable = cfg == "gtklock";
in
{
  config = lib.mkIf enable {
    environment.systemPackages = [
      pkgs.gtklock
    ];

    # gtklock needs PAM access to authenticate, else it fallbacks to su
    security.pam.services.gtklock = { };

    # integrate gtklock with systemd
    services.systemd-lock-handler.enable = true;
    systemd.user.services.systemd-lock-handler-gtklock = {
      unitConfig = {
        Description = "Screen locker for Wayland";
        OnSuccess = "unlock.target";
        PartOf = "lock.target";
        After = "lock.target";
      };
      serviceConfig = {
        Type = "forking";
        ExecStart = "${lib.getExe pkgs.gtklock} -d";
        Restart = "on-failure";
        RestartSec = 0;
      };
      wantedBy = [ "lock.target" ];
    };
  };
}
