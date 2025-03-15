{ lib
, config
, ...
}:

let
  cfg = config.locker;
  enable = cfg == "hyprlock";
in
{
  config = lib.mkIf enable {
    programs.hyprlock.enable = true;

    systemd.user.services.systemd-lock-handler-hyprlock = {
      unitConfig = {
        Description = "Screen locker for Wayland";
        OnSuccess = "unlock.target";
        PartOf = "lock.target";
        After = "lock.target";
      };
      serviceConfig = {
        Type = "forking";
        ExecStart = "${lib.getExe config.programs.hyprlock.package}";
        Restart = "on-failure";
        RestartSec = 0;
      };
      wantedBy = [ "lock.target" ];
    };
  };
}
