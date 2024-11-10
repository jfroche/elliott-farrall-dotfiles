{ config
, lib
, ...
}:

let
  cfg = config.editor;
  enable = cfg == "vscode-insiders";
in
{
  config = lib.mkIf enable {
    home.activation = {
      linkVscodeInsiders = lib.internal.mkLinkScript "${config.xdg.dataHome}/vscode-insiders" "${config.home.homeDirectory}/.vscode-insiders";
      linkPki = lib.internal.mkLinkScript "${config.xdg.dataHome}/pki" "${config.home.homeDirectory}/.pki";
    };
  };
}
