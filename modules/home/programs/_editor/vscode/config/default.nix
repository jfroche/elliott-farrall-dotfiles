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
    # config here
  };
}
