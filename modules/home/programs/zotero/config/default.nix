{ lib
, config
, ...
}:

let
  cfg = config.programs.zotero;
  inherit (cfg) enable;

  id = "tvqk3odd";
in
{
  config = lib.mkIf enable {
    xdg.configFile."zotero/profiles.ini".text = ''
      [General]
      StartWithLastProfile=1

      [Profile0]
      Name=default
      IsRelative=1
      Path=${id}.default
      Default=1
    '';
  };
}
