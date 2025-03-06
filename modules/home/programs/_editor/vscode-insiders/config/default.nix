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
    # config here
  };
}
