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
  options = {
    programs.remarkable.enable = lib.mkEnableOption "reMarkable";
  };

  config = lib.mkIf enable {
    home.packages = with pkgs; [
      rmview
      qt5.qtwayland
    ];
  };
}
