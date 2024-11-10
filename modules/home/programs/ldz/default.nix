{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.programs.ldz;
  inherit (cfg) enable;
in
{
  options = {
    programs.ldz.enable = lib.mkEnableOption "LDZ App";
  };

  config = lib.mkIf enable {
    home.packages = with pkgs.ldz; [
      ldz
    ];
  };
}
