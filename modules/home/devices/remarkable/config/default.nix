{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.devices.remarkable;
  inherit (cfg) enable;

  hostname = "elliotts-remarkable";
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
