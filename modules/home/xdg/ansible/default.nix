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
    # home.sessionVariables = {
    #   ANSIBLE_HOME = "${config.xdg.configHome}/ansible";
    # };
  };
}
