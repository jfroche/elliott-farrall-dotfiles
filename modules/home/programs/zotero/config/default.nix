{ config
, lib
, ...
}:

let
  cfg = config.programs.zotero;
  inherit (cfg) enable;

  id = "tvqk3odd";
in
{
  config = lib.mkIf enable {
    xdg.configFile."zotero/profiles.ini" = {
      text = ''
        [General]
        StartWithLastProfile=1

        [Profile0]
        Name=default
        IsRelative=1
        Path=${id}.default
        Default=1
      '';
      force = true;
    };

    xdg.configFile."zotero/${id}.default/user.js" = {
      text = ''
        user_pref("extensions.zotero.dataDir", "${config.xdg.dataHome}/zotero");
      '';
    };

    home.activation = {
      linkZotero = lib.internal.mkLinkScript' "${config.xdg.configHome}" "${config.home.homeDirectory}/.zotero";
      linkMozilla = lib.internal.mkLinkScript "${config.xdg.dataHome}/mozilla" "${config.home.homeDirectory}/.mozilla";
    };
  };
}
