{ config
, host
, ...
}:

{
  age.secrets.tailscale.file = ./key.age;

  services.tailscale = {
    enable = true;
    authKeyFile = config.age.secrets.tailscale.path;
    extraUpFlags = [ "--ssh" "--hostname" host ];
  };
}
