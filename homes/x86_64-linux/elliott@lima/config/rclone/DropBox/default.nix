{ mkService
, ...
}:

{ config
, ...
}:

{
  age.secrets = {
    "rclone/DropBox/token" = {
      file = ./token.age;
      substitutions = [ "${config.xdg.configHome}/rclone/rclone.conf" ];
    };
  };

  xdg.configFile."rclone/rclone.conf".text = ''
    [DropBox]
    type = dropbox
    token = @rclone/DropBox/token@
  '';

  systemd.user.services.rclone-DropBox = mkService "DropBox" "/";
}
