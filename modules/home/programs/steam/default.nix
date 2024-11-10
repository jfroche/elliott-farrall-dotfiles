{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.programs.steam;
  inherit (cfg) enable;
in
{
  options = {
    programs.steam.enable = lib.mkEnableOption "Steam";
  };

  config = lib.mkIf enable {
    home.packages = with pkgs; [
      steam
    ];
  };
}
