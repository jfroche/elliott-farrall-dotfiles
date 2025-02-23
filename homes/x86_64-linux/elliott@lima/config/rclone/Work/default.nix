{ mkService
, ...
}:

{ config
, ...
}:

{
  age.secrets = {
    "rclone/Work/id" = {
      file = ./id.age;
      substitutions = [ "${config.xdg.configHome}/rclone/rclone.conf" ];
    };
    "rclone/Work/token" = {
      file = ./token.age;
      substitutions = [ "${config.xdg.configHome}/rclone/rclone.conf" ];
    };
  };

  xdg.configFile."rclone/rclone.conf".text = ''
    [Work]
    type = onedrive
    token = @rclone/Work/token@
    drive_id = @rclone/Work/id@
    drive_type = business
  '';

  systemd.user.services.rclone-Work = mkService "Work" "/";
}
