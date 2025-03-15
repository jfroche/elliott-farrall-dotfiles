{ lib
, config
, ...
}:

let
  cfg = config.xdg;
  inherit (cfg) enable;
in
{
  config = lib.mkIf enable {
    home.sessionVariables = {
      BUNDLE_USER_CONFIG = "${config.xdg.configHome}/bundle";
      BUNDLE_USER_CACHE = "${config.xdg.configHome}/bundle";
      BUNDLE_USER_PLUGIN = "${config.xdg.configHome}/bundle";
    };
  };
}
