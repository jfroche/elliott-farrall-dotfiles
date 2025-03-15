{ lib
, config
, osConfig ? null
, ...
}:

let
  cfg = config.xdg;
  enable = cfg.enable && (osConfig.virtualisation.docker.enable or false);
in
{
  config = lib.mkIf enable {
    home.sessionVariables.DOCKER_CONFIG = "${config.xdg.configHome}/docker";
  };
}
