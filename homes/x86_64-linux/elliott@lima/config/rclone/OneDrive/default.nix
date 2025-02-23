{ mkService
, ...
}:

{ config
, ...
}:

{
  age.secrets = {
    "rclone/OneDrive/id" = {
      file = ./id.age;
      substitutions = [ "${config.xdg.configHome}/rclone/rclone.conf" ];
    };
    "rclone/OneDrive/token" = {
      file = ./token.age;
      substitutions = [ "${config.xdg.configHome}/rclone/rclone.conf" ];
    };
  };

  xdg.configFile."rclone/rclone.conf".text = ''
    [OneDrive]
    type = onedrive
    token = @rclone/OneDrive/token@
    drive_id = @rclone/OneDrive/id@
    drive_type = personal
  '';

  systemd.user.services.rclone-OneDrive = mkService "OneDrive" "/";
}
