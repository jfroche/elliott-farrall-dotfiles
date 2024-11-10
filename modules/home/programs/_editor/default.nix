{ config
, lib
, ...
}:

let
  cfg = config.editor;
  enable = cfg != null;
in
{
  options = {
    editor = lib.mkOption {
      type = lib.types.enum [
        "vscode"
        "vscode-insiders"
        null
      ];
      default = null;
      description = "The text editor to use.";
    };
  };

  config = lib.mkIf enable {

  };
}
