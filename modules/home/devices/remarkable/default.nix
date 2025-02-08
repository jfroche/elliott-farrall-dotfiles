{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.devices.remarkable;
  inherit (cfg) enable;
in
{
  options = {
    devices.remarkable.enable = lib.mkEnableOption "reMarkable";
  };

  config = lib.mkIf enable {
    home.packages = with pkgs; [
      rmview
      qt5.qtwayland
    ];
  };
}
