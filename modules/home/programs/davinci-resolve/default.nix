{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.programs.davinci-resolve;
  inherit (cfg) enable;
in
{
  options = {
    programs.davinci-resolve.enable = lib.mkEnableOption "DaVinci Resolve";
  };

  config = lib.mkIf enable {
    home.packages = with pkgs; [
      davinci-resolve
    ];
  };
}
