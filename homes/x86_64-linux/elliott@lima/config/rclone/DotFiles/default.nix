{ mkService
, ...
}:

{ config
, ...
}:

{
  age.secrets = {
    "rclone/DotFiles/url" = {
      file = ./url.age;
      substitutions = [ "${config.xdg.configHome}/rclone/rclone.conf" ];
    };
    "rclone/DotFiles/id" = {
      file = ./id.age;
      substitutions = [ "${config.xdg.configHome}/rclone/rclone.conf" ];
    };
    "rclone/DotFiles/key" = {
      file = ./key.age;
      substitutions = [ "${config.xdg.configHome}/rclone/rclone.conf" ];
    };
  };

  xdg.configFile."rclone/rclone.conf".text = ''
    [DotFiles]
    type = s3
    provider = Cloudflare
    access_key_id = @rclone/DotFiles/id@
    secret_access_key = @rclone/DotFiles/key@
    endpoint = @rclone/DotFiles/url@
    acl = private
  '';

  systemd.user.services.rclone-DotFiles = mkService "DotFiles" "/dotfiles";
}
