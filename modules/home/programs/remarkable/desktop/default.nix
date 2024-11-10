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
    xdg.desktopEntries."rmview" = {
      name = "reMarkable";
      comment = "A live viewer for reMarkable written in PyQt5";
      icon = ./icon.jpeg;
      noDisplay = false;

      exec = "${pkgs.rmview}/bin/rmview";
      type = "Application";
    };
  };
}
