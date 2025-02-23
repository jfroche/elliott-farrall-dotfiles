{ mkService
, ...
}:

{ config
, ...
}:

{
  age.secrets = {
    "rclone/Google/token" = {
      file = ./token.age;
      substitutions = [ "${config.xdg.configHome}/rclone/rclone.conf" ];
    };
  };

  xdg.configFile."rclone/rclone.conf".text = ''
    [Google]
    type = drive
    token = @rclone/Google/token@
    team_drive =
  '';

  systemd.user.services.rclone-Google = mkService "Google" "/";
}
