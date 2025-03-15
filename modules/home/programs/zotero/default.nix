{ lib
, pkgs
, config
, ...
}:

let
  cfg = config.programs.zotero;
  inherit (cfg) enable;
in
{
  options = {
    programs.zotero.enable = lib.mkEnableOption "Zotero";
  };

  config = lib.mkIf enable {
    home.packages = with pkgs; [ zotero_7 ];
  };
}
