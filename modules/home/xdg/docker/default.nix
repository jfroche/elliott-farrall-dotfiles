{ config
, lib
, ...
}:

let
  cfg = config.xdg;
  inherit (cfg) enable;
in
{
  config = lib.mkIf enable {
    home.sessionVariables = {
      DOCKER_CONFIG = "${config.xdg.configHome}/docker";
    };
  };
}
