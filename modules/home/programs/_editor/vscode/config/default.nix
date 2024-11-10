{ config
, lib
, ...
}:

let
  cfg = config.editor;
  enable = cfg == "vscode";
in
{
  config = lib.mkIf enable {
    home.activation = {
      linkVscode = lib.internal.mkLinkScript "${config.xdg.dataHome}/vscode" "${config.home.homeDirectory}/.vscode";
      linkPki = lib.internal.mkLinkScript "${config.xdg.dataHome}/pki" "${config.home.homeDirectory}/.pki";
    };
  };
}
