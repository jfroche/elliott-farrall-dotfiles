{ config
, lib
, pkgs
, ...
}:

let
  cfg = config.programs.obsidian;
  inherit (cfg) enable;
in
{
  options = {
    programs.obsidian.enable = lib.mkEnableOption "Obsidian";
  };

  config = lib.mkIf enable {
    home.packages = with pkgs; [
      obsidian
    ];

    xdg.mimeApps.defaultApplications = {
      "text/markdown" = "obsidian.desktop";
    };
  };
}
