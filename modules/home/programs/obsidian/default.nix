{ lib
, pkgs
, config
, ...
}:

let
  cfg = config.programs.obsidian;
  inherit (cfg) enable;

  inherit (lib.internal) mkDefaultApplications;
in
{
  options = {
    programs.obsidian.enable = lib.mkEnableOption "Obsidian";
  };

  config = lib.mkIf enable {
    home.packages = with pkgs; [
      obsidian
    ];

    xdg.mimeApps.defaultApplications = mkDefaultApplications "obsidian.desktop" [
      "text/markdown"
    ];
  };
}
