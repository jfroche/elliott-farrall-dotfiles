{ config
, lib
, ...
}:

let
  cfg = config.file-manager;
  enable = cfg != null;
in
{
  options = {
    file-manager = lib.mkOption {
      type = lib.types.enum [
        "nemo"
        null
      ];
      default = null;
      description = "The file manager to use.";
    };
  };

  config = lib.mkIf enable {

  };
}
