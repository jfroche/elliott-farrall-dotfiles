{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.programs.remarkable;
  inherit (cfg) enable;
in
{
  config = lib.mkIf enable {
    home.sessionVariables = {
      RMVIEW_CONF = pkgs.writeText "rmview.json" (builtins.toJSON {
        ssh = {
          address = config.programs.ssh.matchBlocks.reMarkable.data.hostname;
          key = config.age.secrets.remarkable.path;
        };
      });
    };
  };
}
