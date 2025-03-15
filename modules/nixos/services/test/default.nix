{ lib
, config
, ...
}:

let
  cfg = config.services.test;
  inherit (cfg) enable;
in
{
  options = {
    services.test.enable = lib.mkEnableOption "test service";
  };

  config = lib.mkIf enable {
    systemd.services.test = {
      description = "Test service";
      script = "test";
    };
  };
}
