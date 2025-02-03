{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.programs.remarkable;
  inherit (cfg) enable;

  hostname = "remarkable";
in
{
  config = lib.mkIf enable {
    programs.ssh.matchBlocks.${hostname}.user = "root";

    home.sessionVariables.RMVIEW_CONF = pkgs.writeText "rmview.json" (builtins.toJSON {
      ssh = {
        address = hostname;
        password = "";
        tunnel = true;
      };
    });
  };
}
